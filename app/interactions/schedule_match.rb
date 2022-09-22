class ScheduleMatch < ApplicationInteraction
  string :schedule_date, default: nil
  include SportUtility

  # We move supervise_api_access in an module when fetching multiple
  # sports data
  def supervise_api_access
    yield
    # rescue ::StandardError => exception
    #   custom_error_logger(exception)
  end

  def execute
    supervise_api_access do
      data = client.schedules(schedule_date).with_indifferent_access
      data[:schedule][:sport_event].each do |event|
        next unless Constants::SUPPORTED_SPORTS.include?(event[:tournament][:sport][:name].downcase)
        next unless %w[booked bookable].include?(event[:liveodds])
        @count = 0
        process_event(event)
      end
    end
  end

  private

  def process_event(event)
    @tournament = Sportable::Create::Tournaments.run!(fetch_tournament_data(event[:tournament]))
    @season = update_season(event[:season])
    return unless (match = update_match(event))&.persisted?
    update_venue(match.venue || match.build_venue, event[:venue]) if event[:venue].present?
    update_competitors(event[:competitors], match)
  end

  def client
    @client ||= Betradar::Client.new
  end

  def custom_error_logger(exception)
    Rails.logger.info "[Soccer Api Error] : [#{exception.class}] : [#{exception.cause}]"
    Honeybadger.notify(
      "[Process ScheduleMatch] : [#{exception.class}] : [#{exception.cause}]",
      class_name: exception.class
    )
  end
end
