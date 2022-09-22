class PublisherService
  KEY_NAME = :enabled_publisher_service
  PUBLISHER_MAP = { 
    :ably => Publishers::Ably::PublishData,
    :anycable => Publishers::Anycable::PublishData,
    :cloud_firestore => Publishers::Firebase::CloudFirestore::PublishData,
    :realtime_database => Publishers::Firebase::RealtimeDatabase::PublishData
  }.freeze
  FALLBACK_PUBLISHER = :cloud_firestore

  class << self 
    def activate(publisher_name)
      if PUBLISHER_MAP[publisher_name]
        Rails.cache.write(KEY_NAME, publisher_name)
      end
    end

    def active
      PUBLISHER_MAP[publisher]
    end

    def publisher
      Rails.cache.fetch(KEY_NAME) || FALLBACK_PUBLISHER
    end
  end
end
