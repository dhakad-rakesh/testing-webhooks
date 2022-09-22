module Soccer
  module Feed
    class MarketListJob < ApplicationJob
      queue_as :market_list_job

      def perform
        market_data = client.market_descriptions(false).with_indifferent_access
        supported_markets(market_data).each do |m_data|
          Soccer::Feed::MarketJob.perform_later(m_data)
        end
      end

      private

      def supported_markets(market_data)
        market_data[:market_descriptions][:market].select do |market|
          Constants::SOCCER_SUPPORTED_MARKETS.include?(market[:id])
        end
      end

      def client
        @client ||= Betradar::Client.new
      end
    end
  end
end
