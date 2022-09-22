module GoalServe
  module Format
    class PrematchOdds
      attr_accessor :xml

      def initialize(path="/soccer.json")
        @xml = client.prematch_odds(path)
      end

      def call
        format_api_response
      end

      private

      def format_api_response
        formated_data = []      
        xml[:events].each do |event_id, event_data|
          match = Match.find_by_uid event_id.to_s
          #match = fetch_match(event_data)
          next unless valid?(event_data, match)
          #update_match(event_data, match)
          formated_data << {
            product: event_data[:info][:league_id], #league uid
            event_id: match.uid,
            timestamp: event_data[:info][:unix_time],
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
        # will look if needed
        return if match.status == event_data[:info][:period]
        match.status = event_data[:info][:period]
        
        if Match::GS_STATUSES_FINISHED.include? event_data[:info][:period]
          match.enabled = false
        elsif Match::GS_STATUSES_IN_PROGRESS.include? event_data[:info][:period]
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
        { status: 'not_started', match_status: 'not_started' }
      end

      def odds(event_data, match)
        { markets: markets(event_data, match) }
      end

      def markets(event_data, match)
        markets = event_data[:odds] # goal, half, main
        formated_market_data = {}
        ordered_markets = match.markets_ordering(markets)
        return {} if ordered_markets.blank?
        ordered_markets.each do |market_id, market_data|
          next if Constants::PREMATCH_MARKETS.exclude? market_id.to_s
          formated_market_data[market_id.to_s] = market(market_data, market_id.to_s, event_data[:info])
        end
        formated_market_data
        # return {} if markets.blank?
        # market_data = {}
        # markets.each do |market_uid, odds_data|
        #   next if Constants::ALL_MARKETS.exclude? odds_data[:name]
        #   market_data[market_uid.to_s] = market(market_uid, odds_data)
        # end
        # market_data
      end

      def specifier(data = nil)
        #return "total=" + data[:participants][:"0"][:name] if data[:participants][:"0"].present?
        "49" # for non specifier
      end

      def market(data, market_id, info)
        format_data(data, market_id, outcome(data, info, market_id))
      end

      def format_data(data, market_id, outcomes)
        return nil if outcomes.blank?
        {
          specifier => {
            name: data[:name],
            uid: market_id,
            status: "1",
            specifier: {},
            outcomes: outcomes
          }
        }
      end

      def outcome(data, info, market_id)
        outcomes_data(data[:part], info, market_id)
      end

      def outcomes_data(data, info, market_id)
        outcomes = {}
        data.each do |id, outcome_data|
          id = id.to_s
          outcomes[id] = {
            uid: id,
            odds: outcome_data[:eu],
            active: "1",
            name: outcome_name(outcome_data[:name], info),
            handicap: handicap_name(outcome_data[:name], market_id)
          }
        end
        outcomes
      end

      def handicap_name(name, market_id)
        return "" unless ["2"].include? market_id
        name.split(" ").last
      end

      def outcome_name(name, info)
        name = name.gsub(info[:home_team], 'Home')
        name = name.gsub(info[:away_team], 'Away')
        name
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
