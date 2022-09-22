module Lsports
  class Sports

    class << self

      def create
        load_sports
      end

      private

      def load_sports
        # sport_params = sports_response + esports_response
        sport_params = sports_response
        sport_params.each { |params| create_sport(params) }
        
        # esport_category.sports!
      end

      def sports_response
        payload[:Body].select { |sport| Constants::LSPORTS_SUPPORTED_SPORTS[sport[:Id]] }
      end

      def esport_category
        Sport.find_by(uid: Sport::ESPORTS_ID)
      end

      def create_sport(params)
        sport = Sport.find_or_create_by(
          name: params['Name'],
          uid: params['Id'],
          kind: kind(params['Id']),
          enabled: true,
          status: 'active'
        )
      end

      def payload
        @payload ||= client
                      .sports
                      .with_indifferent_access
      end

      def esports_response
        esports = []
        Sport::SUPPORTED_ESPORTS_MAP.each do |name, id|
          esports << { 'Id' => esport_id(id), 'Name' => name }
        end
        esports
      end

      def esport_id(id)
        Sport::ESPORTS_ID + id.to_s
      end

      def kind(id)
        id.to_s.include?(Sport::ESPORTS_ID) ? Sport::ESPORTS : Sport::SPORTS
      end

      def client
        @client ||= Lsports::Client.new
      end

    end

  end
end
