module Soccer
  module Feed
    module GS
      class MarketListJob < ApplicationJob
        queue_as :market_list_job

        def perform(xml=GoalServe::Feed::MarketList.new.call)
          data = xml.xml_to_hash
          categories = Array.wrap(data[:scores][:category])

          categories.each do |category|
            matches = Array.wrap(category[:matches][:match])
            matches.each do |match|
              markets = Array.wrap(match[:odds][:type])
              markets.each do |market|
                MarketJob.perform_later(market)
              end
            end
          end
        end
      end
    end
  end
end
