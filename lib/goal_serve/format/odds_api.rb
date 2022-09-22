module GoalServe
  module Format
    class OddsApi
      attr_accessor :response, :categories

      def initialize
        # response = GoalServe::Feed::Odds.new
        response = client.live_odds.with_indifferent_access
        @api_response_object = GoalServe::Feed::Odds.new
        @response = response.dig(:scores) || {}
        @categories = @response.dig(:category)
      end

      def call
        if categories.nil?
          Rails.logger.info("======== No odds data return by GoalServe ==========")
          Rails.logger.info(response)
          return Array.new
        end 
        format_api_response
      end

      private

      def format_api_response
        categories.map do |category|
          matches(category).map do |match|
            {
              product: product_id(category),
              event_id: event_id(match),
              timestamp: timestamp(category),
              sport_event_status: sport_event_status(match),
              odds: odds(match)
            }
          end
        end.flatten
      end

      def matches(category)
        Array.wrap(category.dig(:matches, :match))
      end

      def product_id(category)
        category[:id]
      end

      def event_id(match)
        match[:id]
      end

      def timestamp(category)
        response[:ts]
      end

      def sport_event_status(match)
        { status: match[:status], match_status: match[:status] }
      end

      def odds(match)
        { markets: markets(match) }
      end

      def markets(match)
        markets = Array.wrap(match.dig(:odds, :type))
        markets.map do |data|
          market(data)
        end.inject(:merge)
      end

      def market(data)
        specifiers_data = fetch_specifires_data(data)
        if specifiers_data.present?
          { data[:id] => fetch_specifires_data(data)}
        elsif fetch_non_specifires_data(data).present?
          { data[:id] => fetch_non_specifires_data(data) }
        else
          {}
        end
      end

      def fetch_non_specifires_data(data)
        non_specifier_format(data)
      end

      def fetch_specifires_data(data)
        specifiers_data = {}
        Constants::SPECIFIRES.each do |specifier|
          bookmaker = Array.wrap(data.dig(:bookmaker)).detect do |bookmaker|
            allowed_bookmakers?(bookmaker)
          end || {}

          specifiers = Array.wrap(bookmaker[specifier])
          next if specifiers.blank?
          specifiers_data = specifiers.map do |bs|
            specifier_format(data, bs, bookmaker)
          end.inject(:merge)
        end
        specifiers_data
      end

      def specifier_format(data, bs, bookmaker)
        format_data(data, "total=#{bs[:name]}", outcomes_data(Array.wrap(bs.dig(:odd)), bookmaker))
      end

      def non_specifier_format(data)
        format_data(data, '49', outcome(data))
      end

      def format_data(data, indentifier, outcomes)
        return nil if outcomes.blank?
        {
          indentifier => {
            name: data[:value],
            uid: data[:id],
            status: data["stop"] == "False" ? "1" : "0",
            specifier: {},
            outcomes: outcomes
          }
        }
      end

      def outcome(data)
        if @api_response_object.is_a?(GoalServe::Feed::Odds)
          data = Array.wrap(data.dig(:bookmaker)).detect do |bookmaker|
            allowed_bookmakers?(bookmaker)
          end || {}
          outcomes_data(Array.wrap(data.dig(:odd)), data)
        else
          {}
        end
      end

      def outcomes_data(data, bookmaker)
        outcome_data = {}
        data.each_with_index do |row, i|
          stamp = DateTime.now.strftime('%12N').to_s
          outcome_data[stamp] = {
            uid: stamp,
            odds: row[:value], active: '1', name: row[:name]
          }
        end
        outcome_data
      end

      def allowed_bookmakers?(bookmaker)
        @api_response_object.allowed_bookmaker_ids
                            .include?(bookmaker[:id])
      end

      def client
        @client ||= GoalServe::Client.new
      end
    end
  end
end
