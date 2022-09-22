module SportUtility
  def fetch_tournament_data(tournament)
    { name: tournament[:name], uid: tournament[:id],
      sport: update_sport(tournament[:sport]), category_name: tournament[:category][:name] }
  end

  def update_match(data)
    match = Match.find_or_initialize_by(uid: data[:id])
    match.assign_attributes(
      tournament_id: @tournament.id, schedule_at: data[:scheduled],
      status: match.load_status(data[:status].to_sym), sport_id: @sport.id,
      season_id: @season&.id, booking_status: data[:liveodds]
    )
    begin
      match.save!
    rescue ::StandardError => exception
      handle_exception_and_retry_updation(exception, data)
    end
    match
  end

  def handle_exception_and_retry_updation(exception, data)
    custom_error_logger(exception) and return if !exception.message&.include?('Uid has already been taken') ||
                                                 @count.to_i > 2
    @count = @count.to_i + 1
    update_match(data)
  end

  def update_sport(sport)
    @sport = Sportable::Create::Sports.run!(name: sport[:name], status: :active,
                                         uid: sport[:id])
  end

  def update_season(season)
    return if season.blank?
    Sportable::Create::Seasons.run!(name: season[:name], uid: season[:id],
                                 start_time: season[:start_date],
                                 end_time: season[:end_date],
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

  def update_competitors(competitors, match)
    ActiveRecord::Base.transaction do
      team_info = {}
      competitors[:competitor].each do |team_data|
        team = Sportable::Create::Teams.run!(team_attributes(team_data))
        Sportable::Feed::PlayerListJob.perform_later(team.uid)
        @tournament.team_tournaments.find_or_create_by(team_id: team.id)
        competitor_info_update(match, team, team_data)
        team_info[team.uid] = { id: team.id, name: team.name, qualifier: team_data[:qualifier], acronym: team.acronym }
      end
      match.team_info = team_info
      match.save(validate: false)
    end
  end

  def competitor_info_update(match, team, team_data)
    competitor = match.competitors.find_or_initialize_by(team: team)
    competitor.qualifier = team_data[:qualifier]
    competitor.save!
  end

  def team_attributes(team_data)
    {
      name: team_data[:name], uid: team_data[:id], sport_id: @sport.id,
      country_name: team_data[:country].to_s, acronym: team_data[:abbreviation]
    }
  end
end
