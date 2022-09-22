module AMQP
  class VariantMarket < AMQP::Base
    string :urn, :market_uid, :market_data_id

    set_callback :validate, :after, -> { initialize_options }

    def execute
      @market = Market.find_or_initialize_by(uid: market_uid, name: @new_market_data[:name], is_specifier_market: true)
      # @market.fetch_specifier_text(new_market_data)
      @market.specifier_text = Utility::MarketUtility.fetch_specifier_text(new_market_data)
      outcomes = @new_market_data[:outcomes] && @new_market_data[:outcomes][:outcome]
      Array.wrap(outcomes).compact.each do |outcome_data|
        @market.outcomes.find_or_initialize_by(uid: outcome_data[:id], name: outcome_data[:name])
      end
      @market.save! && @market
    end

    private

    def initialize_options
      data = client.variant_market_descriptions(market_data_id, urn)
                   .with_indifferent_access
      @new_market_data = data[:market_descriptions][:market]
    end

    def client
      @client ||= ::Betradar::Client.new
    end
  end
end
