class OddStoreService
  KEY_NAME = :enabled_odd_store_service

  ODD_STORE_MAP = { 
    :memcache => OddsStore::Memcache,
    :redis => OddsStore::Redis,
    :cloud_firestore => OddsStore::CloudFirestore
  }.freeze

  FALLBACK_STORE = :redis

  class << self 
    def activate(store_name)
      if ODD_STORE_MAP[store_name]
        Rails.cache.write(KEY_NAME, store_name)
      end
    end

    def active
      ODD_STORE_MAP[odd_store]
    end

    def odd_store
      Rails.cache.fetch(KEY_NAME) || FALLBACK_STORE
    end
  end
end
