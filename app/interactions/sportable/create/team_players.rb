module Sportable
  module Create
    class TeamPlayers < Sportable::Base
      string :name, :nationality, :gender, :uid, :player_type, :country_code,
        :full_name, :dob, :jersey_number, default: nil
      object :team
      validates :name, :uid, :gender, presence: true
      set_callback :validate, :before, -> { set_dob }

      def execute
        teamplayer = TeamPlayer.find_or_initialize_by(uid: uid)
        begin
          teamplayer.update!(inputs) && teamplayer
        rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid
          TeamPlayer.find_by(uid: uid)
        end
      end

      def set_dob
        self.dob =
          begin
            dob.to_s.to_date
          rescue ArgumentError => _e
            nil
          end
      end
    end
  end
end
