require 'open-uri'

module Casino
  class CreateOrUpdateItems
      class << self

      def execute
        result = RestClient.get("https://#{Figaro.env.CASINO_KEY}:#{Figaro.env.CASINO_API_TOKEN}@#{Figaro.env.CASINO_HOST_NAME}/api/lobby/v1/#{Figaro.env.CASINO_KEY}/state")
        data = JSON.parse(result)
        @response = data['tables']
        create_or_update_casino_games
      end

      private

      def create_or_update_casino_games
        @response.each do |uuid, details|
          menu_type = details.dig('gameTypeUnified').first(4).eql?('rng-') ? 0 : 1
          unless menu_type.zero?
            name = 
             if details['gameType'].downcase.include?('roulette')
                'Roulette'
             elsif details['gameType'].downcase.include?('blackjack')
                'Blackjack'
             end
           end
          casino_menu = CasinoMenu.find_or_create_by(name: name ||details['gameTypeUnified'], menu_type: menu_type)
          if ci = casino_menu.casino_items.find_by(uuid: uuid)
            ci.update(casino_params(details))
          else
            item = casino_menu.casino_items.new(casino_params(details).merge(uuid: uuid))
            downloaded_image = Down.download("https://#{Figaro.env.CASINO_KEY}:#{Figaro.env.CASINO_API_TOKEN}@#{Figaro.env.CASINO_HOST_NAME}#{details.dig('videoSnapshot','links','M')}")
            item.thumbnail_image.attach(io: downloaded_image  , filename: "#{details.dig('name')}.jpg")
            item.image = Rails.application.routes.url_helpers.url_for(item.thumbnail_image)
            item.save
          end
        end
      end

      def casino_params(details)
        { name: details.dig('name'),
        item_type: details.dig('gameTypeUnified'),
        active: details.dig('open')}
      end

    end
  end
end
