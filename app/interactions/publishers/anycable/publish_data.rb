module Publishers
  module Anycable
    class PublishData < ApplicationInteraction
      string :channel_name
      hash :data, strip: false, default: {}
      validates :data, :channel_name, presence: true

      def execute
        ActionCable.server.broadcast(channel_name, data) 
      end
    end
  end
end

