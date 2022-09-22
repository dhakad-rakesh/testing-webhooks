module Lsports
  module Format
    class PrematchOdds
      attr_accessor :xml, :sport

      def initialize(sport)
        @sport = sport
        @xml = client.fixture_markets.try(:with_indifferent_access)
      end

      def call
        return [] if xml.nil?

        data = format_api_response
        create_zip_file("ls_#{sport.name}_fixture_market.json", data)
        data
      end

      private

      def create_zip_file(file_name, data)
        begin
          file_name = "/tmp/#{file_name}"
          FileUtils.rm_f("#{file_name}.gz") if File.exist?("#{file_name}.gz")
          file = File.open(file_name, "w+")
          file.rewind
          file.write(data)
          file.close
          system("gzip #{file_name}")
          FileUtils.rm_f(file.path) if File.exist?(file.path)
        rescue ::StandardError => exception
          nil
        end
      end

      def format_api_response
        formated_data = []
        xml[:Body].each do |fixture|
          fixture_id = fixture[:FixtureId]
          markets = fixture[:Markets]

          match = Match.find_by uid: fixture_id.to_s

          next if match.blank?

          formated_data << {
            product: match.tournament.try(:uid), # league uid
            event_id: match.uid,
            timestamp: xml[:Header][:ServerTimestamp],
            odds: odds(markets, match)
          }
        end

        formated_data.compact
      end

      def odds(markets_data, match)
        { markets: markets(markets_data, match) }
      end

      def markets(markets_data, match)
        formated_market_data = {}
        ordered_markets = match.markets_ordering(markets_data)

        return {} if ordered_markets.blank?

        ordered_markets.each do |market_data|
          market_id = market_data[:Id].to_s
          # next if Constants::PREMATCH_MARKETS.exclude? market_id
          
          _market = market(market_data, market_id, market_data[:Providers])
          next if _market.blank?

          create_sport_markets_mapping!(
            market_id: market_id,
            match: match
          )

          formated_market_data[market_id] = _market
        end
        formated_market_data
      end

      def create_sport_markets_mapping!(market_id:, match:)
        market = Market.find_by uid: market_id
        SportMarket.find_or_create_by(market: market, sport: match.sport, priority: market.priority) if market
      end

      def specifier(_data = nil)
        '49'
      end

      def market(data, market_id, providers)
        provider, filtered_providers = *filter_providers(providers)

        return [] if filtered_providers.blank?

        format_data(data, market_id, outcome(filtered_providers, market_id), provider, filtered_providers)
      end

      def format_data(data, market_id, outcomes, provider, filtered_providers)
        return nil if outcomes.blank?

        {
          specifier => {
            name: market_name(market_id),
            uid: market_id,
            status: status(filtered_providers),
            specifier: {},
            outcomes: outcomes,
            provider: provider,
            handicaps: group_outcomes(outcomes),
            categories: categories(market_id)
          }
        }
      end

      def status(filtered_providers)
        _status = filtered_providers[0][:Bets].map{|k| k[:Status]}.uniq
        return _status.uniq.map{|s| Bet.ls_status(s) }.join(', ') if _status.length > 1
        Bet.ls_status(_status.first)
      end

      def outcome(providers, market_id)
        outcomes_data(providers[0][:Bets], market_id)
      end

      def outcomes_data(bets, _market_id)
        outcomes = {}
        bets = order_outcomes(bets, _market_id) if Constants::MARKET_OUTCOME_ORDER.keys.include?(_market_id)
        bets.each do |bet|
          outcomes[bet[:Id].to_s] = {
            uid: bet[:Id].to_s,
            odds: bet[:Price],
            name: bet[:Name],
            handicap: handicap_name(bet),
            status: Bet.ls_status(bet[:Status])
          }
        end
        outcomes
      end

      def order_outcomes(bets, market_id)
        ordered_bets = []
        Constants::MARKET_OUTCOME_ORDER[market_id][:outcomes_name].select{ |outcome| ordered_bets << bets.select { |b| b["Name"] == outcome } }
        ordered_bets.flatten
      end

      def handicap_name(bet)
        bet[:BaseLine]
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
        @client ||= Lsports::Client.new(sport: sport, params: schedule_between)
      end

      def filter_providers(providers)
        name = 'Bet365'
        data = filter_providers_by_name(providers, name)
        return [name, data] if data.present?

        # name = 'BWin'
        # data = filter_providers_by_name(providers, name)
        # [name, data]
      end

      def filter_providers_by_name(providers, name)
        providers.select { |p| p[:Name] == name }
      end

      def market_name(market_id)
        Rails.cache.fetch("markets_name_#{market_id}") do
          Market.find_by_uid(market_id).try(:fancy_name)
        end
      end

      def group_outcomes(outcomes)
        return -1 unless outcomes.values.first[:handicap].present?
        grouped_outcomes = {}
        outcomes.values.each do |outcome|
          grouped_outcomes[outcome[:handicap]] ||= {}
          grouped_outcomes[outcome[:handicap]]["-#{outcome[:uid]}"] = outcome
        end
        grouped_outcomes
      end

      def categories(market_id)
        names = Market.includes(:categories).find_by_uid(market_id).categories.pluck(:name)
        category_names(names)
      end

      def category_names(names)
        names = ['others'] if names.blank?
        Hash[names.zip names]
      end

      def schedule_between
        from_date = (Time.zone.now - 30.minutes).to_i
        to_date = 2.weeks.after.end_of_day.to_i

        { FromDate: from_date, ToDate: to_date }
      end
    end
  end
end
