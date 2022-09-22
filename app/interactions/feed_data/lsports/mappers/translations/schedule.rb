module FeedData
  module Lsports
    module Mappers
      module Translations
        class Schedule < BaseMapper
          # TODO: Add typed response
          # Format { uid: '', name: '', tournament_name: '', country_name: '', team_names: { uid1: :name1 ... } }
    
          def payload
            client.fixtures.with_indifferent_access.dig(:Body) || []
          end
    
          # Iteration can be avoided by moving mapper to individual records
          def format_entity(data)
            { 
              uid: data['FixtureId'],
              name: name(data),
              tournament_name: tournament_name(data),
              country_name: country_name(data),
              team_names: team_names(data)
            }
          end

          def name(data)
            ::Match.fetch_name(data[:Fixture][:Participants][0][:Name], data[:Fixture][:Participants][1][:Name])
          end

          def tournament_name(data)
            "#{data[:Fixture][:Location][:Name]} #{data[:Fixture][:League][:Name]}"
          end

          def country_name(data)
            data[:Fixture][:Location][:Name]
          end

          def team_names(data)
            names = {}
            data[:Fixture][:Participants].each do |participant|
              names[participant[:Id].to_s] = participant[:Name]            
            end
            names
          end
        end
      end
    end
  end
end
