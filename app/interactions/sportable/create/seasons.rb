module Sportable
  module Create
    class Seasons < Sportable::Base
      string :name, :uid, :start_time, :end_time
      integer :sport_id, :tournament_id
      validates :name, :start_time, :uid, :sport_id, :tournament_id, presence: true
      set_callback :validate, :before, -> { parse_duration }

      def execute
        season = Season.find_or_initialize_by(uid: uid)
        season.update!(inputs)
        # begin
        #   season.update!(inputs) && season
        # rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid
        #   Season.find_by(uid: uid)
        # end
      end

      def parse_duration
        self.start_time = Time.zone.parse(start_time)
        self.end_time = self.start_time + 1.month
      end
    end
  end
end
