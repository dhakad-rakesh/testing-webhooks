module FeedData
  module Lsports
    module Mappers
      module Translations
        class Market < BaseMapper
          # TODO: Add typed response
          # Format { uid: 1, name: X }

          def payload
            client.markets.with_indifferent_access.dig(:Body) || []
          end
    
          # Iteration can be avoided by moving mapper to individual records
          def format_entity(data)
            { uid: data[:Id], name: data[:Name] }
          end
        end
      end
    end
  end
end
