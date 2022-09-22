module Qtech
  class CreateGame < ApplicationInteraction
    hash :data, strip: false

    def execute
      categories = data[:category].split('/')
      category = live_casino?(categories) ? categories[2] : categories[1]
      obj = CasinoMenu.find_or_create_by(name: category, menu_type: live_casino?(categories) ? :live : :non_live )
      QTechCasinoGame.where(uid: data[:id]).first_or_initialize.tap do |game|
        assign_params(game, obj.id)
        game.save!
      end

    rescue ::StandardError => e
      custom_error_logger(e)
    end

    private

    def assign_params(game, cat_id)
      game.assign_attributes(uid: data[:id], name: data[:name], provider: data[:provider],
                                category: data[:category], supports_demo: data[:supportsDemo],
                                client_types: data[:clientTypes], languages: data[:languages],
                                currencies: data[:currencies], supported_devices: data[:supportedDevices],
                                free_spin_trigger: data[:freeSpinTrigger], casino_menu_id: cat_id)
    end

    def custom_error_logger(exception)
      Honeybadger.notify(
        "[Process Create Games] : [#{exception.class}] : [#{exception.cause}]",
        class_name: exception.class
      )
    end

    def live_casino?(categories)
      categories[1].include?('LIVECASINO')
    end
  end
end
