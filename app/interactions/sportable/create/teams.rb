module Sportable
  module Create
    class Teams < Sportable::Base
      string :name, :country_name, :acronym, :uid
      integer :sport_id
      validates :name, presence: true

      def execute
        team = Team.find_or_initialize_by(uid: uid)

        team.assign_attributes(inputs)
        begin
          team.save! && team
        rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid
          Team.find_by(uid: uid)
        end
      end
    end
  end
end
