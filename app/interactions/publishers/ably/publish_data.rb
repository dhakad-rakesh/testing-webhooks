module Publishers
  module Ably
    class PublishData < ApplicationInteraction
      string :channel_name
      hash :data, strip: false, default: {}
      validates :data, :channel_name, presence: true
      set_callback :execute, :before, -> { client }

      def execute
        channel = @client.channel(channel_name)
        channel.publish(channel_name, data)
      end

      def client
        @client = Ably::Rest.new(key: Figaro.env.ably_key)
      end
    end
  end
end

