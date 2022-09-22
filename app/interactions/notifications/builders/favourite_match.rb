module Notifications
  module Builders
    class FavouriteMatch < ApplicationInteraction
      integer :notification_object_id
      string :kind
  
      set_callback :type_check, :after, :set_match
  
      attr_accessor :match
  
      def execute
        { notification: notification, data: data, topics: topics }
      end
  
      def set_match
        @match ||= Match.find_by(id: notification_object_id)
        errors.add(:base, 'Could not find match') unless match
      end
  
      def notification
        { title: title, body: body }
      end
    
      def title
        key = 'messages.notifications.favourite_match.title'
        localized_message(key, specifiers)
      end

      def body
        key = 'messages.notifications.favourite_match.body'
        localized_message(key, specifiers)
      end

      def localized_message(key, values)
        I18n.t(key, values)
      end

      def specifiers
      { match_name: match.name }
      end
    
      def data
        {
          id: match.id,
          kind: kind,
          status: match.status,
          sport: sport_data
        }
      end
      
      def topics
        team1, team2 = team_topics
        "'#{team1}' in topics || '#{team2}' in topics"
      end

      def team_topics
        channel = Constants::FAVOURITE_TEAM_TOPIC
        match.team_ids.map do |team_id|
          "#{channel}_#{team_id}"
        end
      end

      def sport_data
        {
          id: match.sport.id,
          name: match.sport.name,
          uid: match.sport.uid,
          image_url: "#{ENV['DOMAIN_URL']}#{ActionController::Base.helpers.asset_path("sports_icon/api/#{match.sport.uid}")}"
        }
      end
    end
  end
end

# favourite_matches/team_id