require "google/cloud/firestore"

module OddsStore
  class CloudFirestore

    FIRESTORE = Google::Cloud::Firestore.new(
      project_id: ENV['FIREBASE_PROJECT_ID'],
      credentials: Constants::FIREBASE_KEY_FILE_PATH
    )

    class << self
      def read_with_path(path)
        service.doc(path).get&.data
      end

      def delete_with_path(path)
        service.doc(path).delete
      end

      def read(key)
        service.doc("#{Constants::ODDS_SNAPSHOT_CHANNEL}/#{key.first}").get&.data
      end

      def write(key, data)
        service.doc("#{Constants::ODDS_SNAPSHOT_CHANNEL}/#{key.first}").set(data, merge: true)
      end

      # TODO: Add implementation
      def read_hash(hash, key)
        raise NotImplementedError
      end

      # TODO: Add implementation
      def write_hash(hash, key, data)
        raise NotImplementedError
      end

      # Specify service instance here
      def service
        FIRESTORE
      end
    end
  end
end
