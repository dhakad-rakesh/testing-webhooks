module Sportable
  module Create
    class Sports < Sportable::Base
      string :name, :uid
      symbol :status
      validates :name, :uid, presence: true

      def execute
        sport = Sport.find_or_initialize_by(uid: uid)
        begin
          sport.update!(inputs) && sport
        rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid
          Sport.find_by(uid: uid)
        end
      end
    end
  end
end
