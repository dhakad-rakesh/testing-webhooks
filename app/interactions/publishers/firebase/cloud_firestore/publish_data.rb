require "google/cloud/firestore"

module Publishers
  module Firebase
    module CloudFirestore
      class PublishData < ApplicationInteraction
        string :channel_name
        hash :data, strip: false, default: {}
        validates :data, :channel_name, presence: true
        set_callback :execute, :before, -> { client }

        FIRESTORE = Google::Cloud::Firestore.new(
          project_id: ENV['FIREBASE_PROJECT_ID'],
          credentials: Constants::FIREBASE_KEY_FILE_PATH
        )

        def execute
          client.doc(channel_name).set(data)
        end

        def client
          FIRESTORE
          # @client = Google::Cloud::Firestore.new(
          #   project_id: ENV['FIREBASE_PROJECT_ID'],
          #   credentials: JSON.parse(ENV['FIREBASE_KEY_FILE_PATH'])
          # )
        end
      end
    end
  end
end

