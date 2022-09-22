module LS::SportUtility
  # Here customising LS data for tournament
  def fetch_tournament_data(info)
    { name: fetch_name(info), uid: info[:League][:Id].to_s, sport: fetch_sport(info),
      category_name: info[:League][:Name], country: country(info[:Location]) }
  end

  def fetch_name(info)
    "#{info[:Location][:Name]} #{info[:League][:Name]}"
  end

  def country(location)
    country = Country.find_or_initialize_by(uid: location[:Id].to_s)
    if (!country.persisted? || country.name.blank?)
      country.name = location[:Name]
      country.save
    end
    SportCountry.find_or_create_by(sport_id: @sport.id, country_id: country.id)
    country
  end

  def create_match(fixture_id, info)
    ActiveRecord::Base.transaction do
      match = Match.find_or_initialize_by(uid: fixture_id)

      # enable matches which are `1 not_started 2 about_to_start 9 in_progress`
      # enabled = [1, 2, 9].include?(info[:Status])

      if match.persisted?
        # update only if changed attributes
        match.assign_attributes(schedule_at: match_date(info[:StartDate]),
                                status: match.load_ls_status(info[:Status]))
        match.save! if match.changed?
      else
        # create match
        match_name = Match.fetch_name(info[:Participants][0][:Name], info[:Participants][1][:Name])
        team_info = create_teams(match, info)
        match.assign_attributes(name: match_name, uid: fixture_id, tournament_id: @tournament.id,
                                schedule_at: match_date(info[:StartDate]), team_info: team_info,
                                status: match.load_ls_status(info[:Status]),
                                sport_id: @sport.id)
        match.save!
      end
    end
  end

  def match_status(data)
    return 'not_started' if data[:info][:status] == '0'
  end

  def handle_exception_and_retry_updation(exception, data)
    custom_error_logger(exception) and return if !exception.message&.include?('Uid has already been taken') ||
                                                 @count.to_i > 2
    @count = @count.to_i + 1
    update_match(data)
  end

  def fetch_sport(info)
    @sport = Sport.find_by uid: mapping_id(info)
  end

  def mapping_id(info)
    LS::SportsMapper.new(
      info[:Sport][:Id],
      info[:League][:Name]
    ).call
  end

  # def update_season(fixture_id, info)
  #   @season = Season.find_by(uid: season_id(fixture_id, info))
  #   return if @season.present?

  #   Sportable::Create::Seasons.run!(name: season_name(info), uid: season_id(fixture_id, info),
  #                                start_time: season_start_date(info),
  #                                end_time: season_start_date(info), # just to pass
  #                                sport_id: @sport.id,
  #                                tournament_id: @tournament.id)
  # end

  def create_teams(match, data)
    team_info = {}
    # 0, 1 is Home and Away here
    [0, 1].each do |t|
      team = Sportable::Create::Teams.run!(team_attributes(t, data))
      competitor_info_update(match, team, qualifier(t))
      team_info[team.uid] = { id: team.id, name: team.name, qualifier: qualifier(t),
                              acronym: team.acronym }.with_indifferent_access if team
    end
    team_info
  end

  def competitor_info_update(match, team, qualifier)
    competitor = match.competitors.find_or_initialize_by(team: team)
    competitor.qualifier = qualifier
    competitor.save!
  end

  def team_attributes(t, data)
    {
      name: data[:Participants][t][:Name], uid: data[:Participants][t][:Id].to_s, sport_id: @sport.id,
      country_name: data[:Location][:Name], acronym: team_acronym(t, data)
    }
  end

  def season_name(info)
    info[:League][:Name]
  end

  def season_id(fixture_id, info)
    "#{fixture_id} - #{info[:StartDate]}"
  end

  def season_start_date(info)
    info[:StartDate]
  end

  def match_date(date)
    Time.zone.parse(date)
  rescue StandardError
    nil
  end

  # Keep nil for now
  def booking_status
    # EX: "bookable"
    nil
  end

  def team_acronym(t, data)
    data[:Participants][t][:Name].first(3)
  end

  def qualifier(t)
    t.zero? ? 'home' : 'away'
  end
end
