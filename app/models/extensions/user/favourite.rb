module Extensions
  module User
    module Favourite
      extend ActiveSupport::Concern

      included do
        has_many :favourites, class_name: 'Favourite', foreign_key: :user_id, dependent: :destroy # rubocop:disable Rails/InverseOf
        has_many :favourite_sports, through: :favourites, source: :favouriteable, source_type: 'Sport'
        has_many :favourite_teams, through: :favourites, source: :favouriteable, source_type: 'Team'
        has_many :favourite_tournaments, through: :favourites, source: :favouriteable, source_type: 'Tournament'

        %I[favourite_tournaments favourite_sports favourite_teams].each do |method_name|
          define_method(method_name) { super() || {} }
        end
      end

      def favourite(favouriteable_id)
        favourites.find_by(favouriteable_id: favouriteable_id)
      end

      # TODO : Need to check
      def add_favourite(favourite, type)
        object = type.constantize.find_by(name: favourite)
        unless object.blank? ||
               favourites.any? { |f| f.favouriteable_id == object.id && f.favouriteable_type == object.class.to_s }
          favourites.create(favouriteable_type: object.class, favouriteable_id: object.id)
        end
      end

      def generate_favourites(params)
        %I[favourite_league favourite_tournament favourite_cup].each do |type|
          add_favourite(params[type], 'Tournament')
        end
        add_favourite(params[:favourite_team], 'Team') if params[:favourite_team].present?
      end
    end
  end
end
