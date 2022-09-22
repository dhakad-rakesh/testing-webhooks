module GS
  class ScheduleMatch < ApplicationInteraction
    integer :duration, default: 1
    include GS::SportUtility

    def execute
      begin
        #data = client.schedules('/soccer.json')
        file = File.open "soccer.json", "r"
        file.rewind
        data = eval file.read
        create_matches(data)
      rescue ::StandardError => exception
        custom_error_logger(exception)
        NotificationMailer.schedule_matches_job("#{exception.class} :: #{exception.message}", exception.backtrace.split(",")).deliver_later
      end
    end

    private

    def create_matches(data)
      data[:events].each do |event_id, event_data|
        @tournament = Sportable::Create::Tournaments.run!(fetch_tournament_data(event_data[:info]))
        next unless @tournament.enabled #not creating matches for disable tournaments
        update_season(event_data)
        match = update_match(event_data)
        update_competitors(event_data, match) if match.persisted?
      end
    end

    def process_match(category, match_data)
      @season = update_season(category, match_data)
      return unless (match = update_match(match_data))&.persisted?
      # Not receiving match venue in API response
      # update_venue(match.venue || match.build_venue, event[:venue]) if event[:venue].present?
      update_competitors(category, match_data, match)
    end

    def client
      @client ||= GoalServe::Client.new
    end

    def custom_error_logger(exception)
      Rails.logger.info "[Soccer Api Error] : [#{exception.class}] : [#{exception.cause}]"
      Honeybadger.notify(
        "[Process ScheduleMatch] : [#{exception.class}] : [#{exception.cause}]",
        class_name: exception.class
      )
    end

    def supported_sports?(sport)
      Constants::SUPPORTED_SPORTS.include?(sport)
    end
  end
end
