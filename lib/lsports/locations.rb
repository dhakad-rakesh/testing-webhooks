module Lsports
  class Locations
    class << self
      def create
        locations = client.locations
                         .with_indifferent_access
        create_locations(locations[:Body])
      end

      private

      def create_locations(locations)
        locations.each do |location|
          Country.find_or_create_by(uid: location[:Id]) do |l|
            l.name = location[:Name]
          end
        end
      end

      def client
        @client ||= Lsports::Client.new
      end
    end
  end
end
