module Lsports
  class Markets
    class << self
      def create
        markets = client.markets
                         .with_indifferent_access
        create_markets(markets[:Body])
      end

      private

      def create_markets(markets)
        markets.each do |market_data|
          market = Market.find_or_create_by(uid: market_data[:Id], name: market_data[:Name]) do |m|
            m.provider = 'lsports'
          end
          create_market_category!(market: market)
        end
      end

      def create_market_category!(market:)
        Market::CATEGORIES_MAP[market.uid]&.each do |category_name|
          market.category_joins.find_or_create_by!(
            category: Category.find_by(name: category_name)
          )
        end
      end

      def client
        @client ||= Lsports::Client.new
      end
    end
  end
end
