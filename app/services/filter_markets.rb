class FilterMarkets
  # Call will find markets which are supported by us according to sport and
  # whose outcome is present and it has no varient specifier
  def self.call(markets, match:, variant: false)
    uids = []
    data = Array.wrap(markets).select do |market|
      next unless Array.wrap(match.supported_market_uids).include?(market[:id])
      # variant is present and outcome is present in cache
      if variant && need_to_create_or_assign_outcome?(variant, fetch_market_by_uid(market[:id]), market)
        next if (outcomes = fetch_outcomes(market, variant_key(market))).blank?
        create_or_assign_outcomes(market, outcomes)
      end
      uids.push(market[:id])
    end
    fetch_data_and_markets(uids, match, data)
  end

  class << self
    def fetch_markets(uids, match)
      Market.includes(:outcomes).where(uid: uids)
            .where.not(id: match.inactive_market_ids)
    end

    def fetch_data_and_markets(uids, match, data)
      all_markets = fetch_markets(uids, match)
      uids_all_markets = all_markets.map(&:uid)
      data = data.select { |a| uids_all_markets.include?(a[:id]) }
      [data, all_markets]
    end

    def client
      @client ||= Betradar::Client.new
    end

    def need_to_create_or_assign_outcome?(variant, available_market, market)
      return nil if market[:outcome].blank?
      outcomes_ids = Array.wrap(market[:outcome]).map { |a| a[:id] }.sort
      variant && fetch_outcomes_by_market_and_variant(
        available_market, variant_key(market)
      ).sort_by { |a| a[:id] } != outcomes_ids
    end

    def fetch_outcomes(market, key)
      response = client
                 .variant_market_descriptions(market['id'], key)
                 .with_indifferent_access

      response.dig(:market_descriptions, :market, :outcomes, :outcome)
    rescue StandardError => exception
      Honeybadger.notify(
        "[Process ScheduleMatch] : [#{exception.class}] : [#{exception.cause}]",
        class_name: exception.class,
        data: market
      )
      []
    end

    def create_or_assign_outcomes(market, fetched_outcomes)
      available_market = fetch_market_by_uid(market[:id])
      return if available_market.blank?

      fetched_outcomes.each do |outcome|
        # TODO: create index on outcome's name, id and uid
        out_come = fetch_outcome_by_uid(outcome['id'], outcome['name'])
        next if fetch_outcomes_by_market_and_variant(available_market, variant_key(market)).include?(out_come)
        begin
          available_market.outcomes << out_come
        rescue ActiveRecord::RecordNotUnique => exception
          custom_error_logger(exception)
        end
        # We do not want any validation and callback here we just need to remove the cache and update updated_at
        available_market.touch # rubocop:disable Rails/SkipsModelValidations
      end
    end

    def custom_error_logger(exception)
      Honeybadger.notify(
        "[Job Error] : [#{exception.class}] : [#{exception.cause}]",
        class_name: exception.class
      )
    end

    def fetch_market_by_uid(uid)
      Rails.cache.fetch("market_#{uid}") do
        Market.find_by(uid: uid)
      end
    end

    # TODO: Create common method
    def fetch_outcome_by_uid(uid, name)
      Rails.cache.fetch("outcome_#{uid}_#{name}") do
        Outcome.find_or_create_by(name: name, uid: uid)
      end
    end

    # for developer when we delete outcomes manually, please delete cache too.
    def fetch_outcomes_by_market_and_variant(market, variant_key)
      Rails.cache.fetch("market_#{market.id}_#{market.updated_at}_#{variant_key}_outcomes") do
        market.outcomes.where('uid like ?', "#{variant_key}%").to_a
      end
    end

    def variant_key(market)
      market[:specifiers].split('|').detect { |a| a.include?('variant') }&.split('variant=')&.last
    end
  end
end
