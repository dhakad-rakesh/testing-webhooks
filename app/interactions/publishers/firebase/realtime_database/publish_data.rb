module Publishers
  module Firebase
    module RealtimeDatabase
      class PublishData < ApplicationInteraction
        string :channel_name
        hash :data, strip: false, default: {}
        validates :data, :channel_name, presence: true
        set_callback :execute, :before, -> { client }

        def execute
          client.update(channel_name, data)
        end

        def client
          # @client = ::Firebase::Client.new(
          #   ENV['FIREBASE_DATABASE_URL'],
          #   ENV['FIREBASE_SECRET']
          # )
        end
      end
    end
  end
end

