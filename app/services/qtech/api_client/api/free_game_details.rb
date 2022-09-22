# retrive_access_token
module Qtech
  module ApiClient
    module Api
      module FreeGameDetails
        # {
        #   "txnId": "acfe23cfe4f2",
        #   "playerId": "45465",
        #   "gameId": "QS-goldlab",
        #   "totalBetValue": 100.00,
        #   "currency": "CNY",
        #   "promoCode": "ABC",
        #   "validityDays": 7,
        #   "rejectable": true
        # }
        def create_round(args = {})
          post(
            "#{qt_plate_form_url}/v1/bonus/free-rounds",
            args.to_json,
            qt_plateform_headers.merge(content_type: :json, accept: :json)
          )
        end

        # Time-Zone: Asia/Shanghai in headers
        def round_promotion(bonus_id, player_id)
          get(
            "#{qt_plate_form_url}/v1/bonus/free-rounds/#{bonus_id}/players/#{player_id}",
            qt_plateform_headers
          )
        end

        # currencies can be comma seperated values
        def delete_round_promotion(bonus_id, player_id)
          delete(
            "#{qt_plate_form_url}/v1/bonus/free-rounds/#{bonus_id}/players/#{player_id}",
            qt_plateform_headers
          )
        end

        def jackpot(currencies:, pool_type:)
          get(
            "#{qt_plate_form_url}/v1/jackpots?currencies=#{currencies}&type=#{pool_type}",
            qt_plateform_headers
          )
        end
      end
    end
  end
end
