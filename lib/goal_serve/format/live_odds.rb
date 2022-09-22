module GoalServe
  module Format
    class LiveOdds
      attr_accessor :xml

      def initialize(xml)
        @xml = xml
      end

      def call
        format_api_response
      end

      private

      def format_api_response
        formated_data = []
        xml[:events].each do |event_id, event_data|
          match = Match.find_by_uid event_id.to_s
          next unless valid?(event_data, match)
          #update_match(event_data, match)
          formated_data << {
            product: product_id,
            event_id: match.uid,
            running_time: event_data[:info][:secunds],
            score: event_data[:info][:score],
            timestamp: xml[:updated_ts],
            sport_event_status: sport_event_status(event_data),
            odds: odds(event_data, match)
          }
        end
        formated_data.compact
      end

      def fetch_match(event_data, match = nil)
        home_team = Team.find_by_name event_data[:stats][:"0"][:home]
        away_team = Team.find_by_name event_data[:stats][:"0"][:away]
        return nil if home_team.blank? || away_team.blank?
        (home_team.matches + away_team.matches).uniq.first
      end
        
      def valid?(event_data, match)
        match.present? && event_data[:info][:sport] == "Soccer"
      end

      def update_match(event_data, match)
        #return if match.status == event_data[:info][:period]
        #match.status = event_data[:info][:period]
        if Match::GS_STATUSES_FINISHED.include? event_data[:info][:period]
          match.status = 'ended'
          match.enabled = false
          match.highlight = false
        elsif Match::GS_STATUSES_IN_PROGRESS.include? event_data[:info][:period]
          match.status = 'in_progress'
          match.enabled = true
        elsif Match::GS_STATUSES_NOT_STARTED.include? event_data[:info][:period]
          match.status = 'not_started'
          match.enabled = true
        end
        match.save
      end

      #def matches(xml)
      #  Array.wrap(xml.dig(:events)).first
      #end

      def product_id
        "cat_id_1"#category[:id]
      end

      def event_id(match)
        match[:id]
      end

      def timestamp(category)
        response[:ts]
      end

      def match_status(event_data)
        status = 'ended' if Match::GS_STATUSES_FINISHED.include? event_data[:info][:period]
        status = 'in_progress' if Match::GS_STATUSES_IN_PROGRESS.include? event_data[:info][:period]
        status = 'not_started' if Match::GS_STATUSES_NOT_STARTED.include? event_data[:info][:period]
        status
      end

      def sport_event_status(event_data)
        status = match_status(event_data)
        { status: status, match_status: status }
      end

      def odds(match_xml, match)
        { markets: markets(match_xml, match) }
      end

      def markets(match_xml, match)
        markets = match_xml[:odds]
        return {} if markets.blank?
        market_data = {}
        markets.each do |market_uid, odds_data|
        # formated_market_data = {}
        # ordered_markets = match.markets_ordering(markets)
        # return {} if ordered_markets.blank?
        # ordered_markets.each do |market_id, market_data|
          next if Constants::INPLAY_MARKETS.exclude? odds_data[:id].to_s
          market_data[odds_data[:id].to_s] = market(market_uid, odds_data)
          # formated_market_data[market_id.to_s] = market(market_data, market_id.to_s, event_data[:info])
        end
        # formated_market_data
        market_data
      end

      def specifier(data)
        return "total=" + data[:participants][:"0"][:name] if data[:participants][:"0"].present?
        "49" # for non specifier
      end

      def market(market_uid, data)
        format_data(data, specifier(data), outcome(data))
      end

      def format_data(data, indentifier, outcomes)
        return nil if outcomes.blank?
        {
          indentifier => {
            name: data[:name],
            uid: data[:id].to_s,
            status: data[:suspend].to_s == "0" ? "1" : "0",
            specifier: {},
            outcomes: outcomes
          }
        }
      end

      def outcome(data)
        outcomes_data(data)
      end

      def outcomes_data(data, bookmaker=nil)
        outcomes = {}
        data[:participants].each do |id, outcome_data|
          id = id.to_s
          next if id == "0"
          outcomes[id] = {
            uid: id,
            odds: outcome_data[:value_eu],
            active: outcome_data[:suspend].to_s == "0" ? "1" : "0",
            name: outcome_data[:short_name],
            full_name: outcome_data[:name],
            handicap: data[:id].to_s == "1778" ? data[:name] : outcome_data[:handicap]
          }
        end
        outcomes
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
