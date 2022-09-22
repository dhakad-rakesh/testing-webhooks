module Sportable
  module Create
    class Tournaments < Sportable::Base
      string :name, :uid, :category_name
      object :sport, :country
      validates :name, :uid, presence: true

      def execute
        tournament = sport.tournaments.find_or_initialize_by(uid: inputs[:uid], country_id: country.id)
        begin
          tournament.update!(inputs) && tournament
        rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid
          sport.tournaments.find_by(uid: inputs[:uid], country_id: country.id)
        end
      end
    end
  end
end
