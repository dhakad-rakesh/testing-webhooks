require "uri"
require "net/http"
# retrive_access_token
# Qtech::ApiClient::Client.new
module Qtech
  module ApiClient
    module Api
      module GameDetails
        def list
          get(
            "#{qt_plate_form_url}/v1/games",
            qt_plateform_headers
          )
        end

        # args1 = {
        #   playerId: 'PlayerId',
        #   displayName: 'displayName',
        #   currency: 'INR',
        #   country: 'IN',
        #   gender: 'M',
        #   birthDate: '1994-01-29',
        #   lang: 'en_US',
        #   mode: 'real',
        #   device: 'desktop',
        #   returnUrl: 'http://www.google.com',
        #   walletSessionId: '123456'
        # }
        def game_url(game_id, args = {})
          post(
            "#{qt_plate_form_url}/v1/games/#{game_id}/launch-url",
            args.to_json,
            qt_plateform_headers.merge(content_type: :json, accept: :json)
          )[:url]
        end

        def bet_value(game_id)
          get(
            "#{qt_plate_form_url}/v1/games/#{game_id}/bet-values",
            qt_plateform_headers
          )
        end

        # currencies can be comma seperated values
        def popular_games(currencies, size = 25, page = 1)
          get(
            "#{qt_plate_form_url}/v1/games/most-popular?currencies=#{currencies}&size=#{size}&page=#{page}",
            qt_plateform_headers
          )
        end

        def game_rounds(player_id:, status:, range_filter:, from_date_time:, to_date_time:, size:)
          get(
            "#{qt_plate_form_url}/v1/game-rounds?playerId=#{player_id}&" \
            "status=#{status}&rangeFilter=#{range_filter}&from=#{from_date_time}&" \
            "to=#{to_date_time}&size=#{size}",
            qt_plateform_headers
          )
        end

        def round_details(round_id)
          get(
            "#{qt_plate_form_url}/v1/game-rounds/#{round_id}",
            qt_plateform_headers
          )
        end

        def game_transactions(player_id:, from_date_time:, to_date_time:, size:)
          get(
            "#{qt_plate_form_url}/v1/game-transactions?playerId=#{player_id}&from=#{from_date_time}&to=#{to_date_time}&size=#{size}",
            qt_plateform_headers
          )
        end

        def ngr_per_player(from_date_time:, to_date_time:, embed:)
          get(
            "#{qt_plate_form_url}/v1/ngr-player?from=#{from_date_time}&to=#{to_date_time}&embed=#{embed}",
            qt_plateform_headers
          )
        end

        def qt_plateform_headers
          {
            Authorization: "Bearer #{retrive_access_token[:access_token]}"
          }
        end

        def create_games
          game_data = (list.presence || load_from_file).with_indifferent_access
          game_data[:items].each do |data|
            Qtech::CreateGameJob.perform_now(data)
          end
        end

        def load_from_file
          file = File.open 'public/sports.json'
          JSON.load file
        end
      end
    end
  end
end
