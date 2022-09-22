class OddStore
  def initialize(match_id)
    @match_id = match_id
  end

  def odds_data
    store.read(match_key) || { markets: {} }
  end

  def odds_data=(data)
    store.write(match_key, data)
  end

  def get_market(market_uid)
    store.read_hash(match_key, market_uid) || {}
  end

  def set_market(market_uid, market_data)
    store.write_hash(match_key, market_uid, market_data)
  end

  def get_multiple_markets(market_uids)
    store.read_multiple_keys(match_key, market_uids)
  end

  def remove_odds_data
    store.remove_hash(match_key)
  end

  def store
    OddsStore::Redis
    # OddStoreService.active
  end

  def match_key
    Utility::Cache.odds_change_cache_key(@match_id)
  end
end
