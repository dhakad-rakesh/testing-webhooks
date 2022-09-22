module GS::SportUtility
  #Here customising GS data for tournament  
  def fetch_tournament_data(info)
    { name: fetch_name(info), uid: info[:league_id],
      sport: fetch_sport(info[:sport_id]), category_name: info[:league], country: country(info) }
  end

  def fetch_name(info)
    return info[:country] + " " + info[:league] if info[:country].present?
    info[:league]
  end

  def country(info)
    if info[:country]
      country = Country.find_or_create_by(name: info[:country], uid: info[:country_id])
      SportCountry.find_or_create_by(sport_id: @sport.id, country_id: country.id)
      return country
    end
    Country.find_by(uid: 'world')
  end

  def update_match(data)
    match = Match.find_or_initialize_by(uid: data[:info][:id].to_s)
    match_name = Match.fetch_name(data[:info][:home_team], data[:info][:away_team])
    match.assign_attributes(
      name: match_name, uid: data[:info][:id].to_s,
      tournament_id: @tournament.id, schedule_at: match_date(data),
      status: match_status(data), sport_id: @sport.id,
      season_id: @season&.id, booking_status: booking_status
    )

    begin
      match.save!
    rescue ::StandardError => exception
      handle_exception_and_retry_updation(exception, data)
    end
    match
  end

  def match_status(data)
    return "not_started" if data[:info][:status] == "0"
  end

  def handle_exception_and_retry_updation(exception, data)
    custom_error_logger(exception) and return if !exception.message&.include?('Uid has already been taken') ||
                                                 @count.to_i > 2
    @count = @count.to_i + 1
    update_match(data)
  end

  def fetch_sport(uid)
    @sport = Sport.find_by_uid uid.to_s
  end

  # def update_sport(sport)
  #   @sport = Sportable::Create::Sports.run!(name: sport[:name], status: :active,
  #                                        uid: sport[:id])
  # end

  def update_season(data)
    @season = Season.find_by(uid: season_id(data[:info]))
    return if @season.present?
    Sportable::Create::Seasons.run!(name: season_name(data[:info]), uid: season_id(data[:info]),
                                 start_time: season_start_date(data[:info]),
                                 end_time: season_start_date(data[:info]), #just to pass
                                 sport_id: @sport.id,
                                 tournament_id: @tournament.id)
  end

  def update_venue(venue, venue_data)
    venue.assign_attributes(name: venue_data[:name].downcase,
                            city_name: venue_data[:city_name].downcase,
                            country_name: venue_data[:country_name].downcase,
                            country_code: venue_data[:country_code])
    venue.save(validate: false) && venue
  end

  def update_competitors(data, match)
    ActiveRecord::Base.transaction do
      team_info = {}
      %w[home away].each do |t|
        team = Sportable::Create::Teams.run!(team_attributes(t, data))
        # Sportable::Feed::GS::PlayerListJob.perform_later(team.uid)
        #no need for creating team tournaments
        #@tournament.team_tournaments.find_or_create_by(team_id: team.id)
        
        competitor_info_update(match, team, t)
        team_info[team.uid] = { id: team.id, name: team.name, qualifier: t,
                                acronym: team.acronym }.with_indifferent_access
      end
      match.team_info = team_info
      # match should be save once.
      match.save(validate: false)
    end
  end

  def competitor_info_update(match, team, qualifier)
    competitor = match.competitors.find_or_initialize_by(team: team)
    competitor.qualifier = qualifier
    competitor.save!
  end

  def team_attributes(t, data)
    {
      name: data[:info]["#{t}_team".to_sym], uid: data[:info]["#{t}_id".to_sym], sport_id: @sport.id,
      country_name: data[:info][:country], acronym: team_acronym(t, data)
    }
  end

  # For now taking category name as tournament name  
  def category_name(category)
    category[:name]
  end

  def tournament_sport(sport)
    sport = Sport.find_by(name: sport.capitalize)
    { name: sport.name, id: sport.uid }
  end

  def season_name(info)
    #date = match_date(matches(category).first)
    season_id(info)
  end

  def season_id(info)
    #temp season id created
    info[:league] + "-" + info[:start_date].split(".").first
  end

  def season_start_date(info)
    info[:start_date]
  end

  # def season_end_date(info)
  #   (info[:start_date].to_date + 1.month).to_s
  # end

  def match_date(data)
    DateTime.parse(data[:info][:start_date].to_s + " " + data[:info][:start_time].to_s) rescue nil
  end

  #Keep nil for now
  def booking_status
    #EX: "bookable"
    nil
  end

  def country_name(category)
    category[:name].split(":")[0]
  end

  def team_acronym(t, data)
    data[:info]["#{t}_team".to_sym].first(3)
  end

  def matches(category)
    Array.wrap(category[:matches][:match])
  end
end
