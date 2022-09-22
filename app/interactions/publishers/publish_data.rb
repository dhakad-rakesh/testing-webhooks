module Publishers
  class PublishData < ApplicationInteraction
    string :channel_name
    hash :data, strip: false, default: {}
    validates :data, :channel_name, presence: true
    set_callback :execute, :before, -> { provider }

    def execute
      provider.run!(channel_name: channel_name, data: data)
    end

    def provider
      Publishers::Firebase::CloudFirestore::PublishData
      # PublisherService.active 
    end
  end
end
