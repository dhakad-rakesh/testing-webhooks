module Qtech
  module ApiClient
    module Api
      module PlayerGameHistory

        # args = {
        #   "currency":"CNY",
        #   "country":"CN",
        #   "gender":"M",
        #   "birthDate":"1986-01-01",
        #   "lang":"zh_CN",
        #   "timeZone":"Asia/Shanghai"
        # }

        def player_game_details(player_id, args = {})
          post(
            "#{qt_plate_form_url}/v1/players/#{player_id}/service-url",
            args, qt_plateform_headers
          )
        end

      end
    end
  end
end
