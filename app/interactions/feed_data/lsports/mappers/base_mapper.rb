module FeedData
  module Lsports
    module Mappers
      class BaseMapper < ApplicationInteraction
        hash :params, strip: false

        def execute
          payload.map { |data| format_entity(data) }
        end

        def payload
          raise NotImplementedError
        end
  
        def client
          @client ||= ::Lsports::Client.new(params: lsport_params)
        end
  
        def lsport_params
          { lang: language_param, sports: params[:sport_uid] }.compact
        end
  
        def language_param
          Constants::LSPORTS_LANGUAGE_MAP[params[:locale]] || :en
        end
      end
    end
  end
end
