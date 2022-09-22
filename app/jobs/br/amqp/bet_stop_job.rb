module BR
  module AMQP
    class BetStopJob < ApplicationJob
      queue_as :bet_stop
      include Utility::JobUtility::BetStopUtility

      def perform(xml_data, routing_key)
        json_data = xml_data.xml_to_hash
        event_id = json_data.dig(:bet_stop, :event_id)
        @match = routing_key.include?('match') && Match.find_by(uid: event_id)
        return if @match.blank? || @match.non_supported_tournament?
        publish_data(json_data.dig(:bet_stop, :groups))
        update_markets_status(@match)
        # inactive_markets = Market.select(:id, :uid).where(uid: Utility::Sport.info(match).supported_market_uids)
        # match&.update(inactive_market_ids: inactive_markets.pluck(:id))
      end

      def publish_data(data)
        Firebase::PublishData.run!(channel_name: Constants::BET_STOP_CHANNEL, data: { @match.id => data })
      end
    end
  end
end
