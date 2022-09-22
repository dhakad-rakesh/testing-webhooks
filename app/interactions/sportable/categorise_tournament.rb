module Sportable
  class CategoriseTournament < Base
    object :tournament

    def execute
      return if tournament.blank?
      tournament.update!(tournament_type: category)
    end

    private

    def client
      @client ||= Betradar::Client.new
    end

    def fetch_match_types
      begin
        data = client.tournament_schedule(tournament.uid)
      rescue Betradar::Error::NotFound => e
        custom_error_logger(e)
        return nil
      end
      matches = data.with_indifferent_access.dig(:tournament_schedule, :sport_events, :sport_event)
      Array.wrap(matches).map { |event| event[:tournament_round] && event[:tournament_round][:type] }.uniq
    end

    def category
      match_types = fetch_match_types
      return 0 if match_types.nil?
      if match_types.include?('group') && match_types.include?('cup')
        2
      else
        match_types.include?('group') ? 1 : 3
      end
    end

    def custom_error_logger(exception)
      Rails.logger.info "[Soccer Api Error] : [#{exception.class}] : [#{exception.cause}]"
    end
  end
end
