module FeedData
  module Lsports
    module Mappers
      module Translations
        class Sport < BaseMapper
          # TODO: Add typed response
          # Format { uid: 1, name: X }

          def payload
            sport_data = client.sports.with_indifferent_access.dig(:Body) || []
            sport_data + esports_data
          end

          def esports_data
            esports = []
            ::Sport::SUPPORTED_ESPORTS_MAP.each do |_, id|
              esports << { 'Id' => esport_id(id), 'Name' => translated_name(id) }
            end
            esports
          end

          def esport_id(id)
            ::Sport::ESPORTS_ID + id.to_s
          end
    
          def translated_name(id)
            ::Sport::ESPORTS_NAMES_MAP.dig(id, params[:locale])
          end

          def format_entity(data)
            { uid: data['Id'], name: data['Name'] }
          end
        end
      end
    end
  end
end
