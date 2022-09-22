module Sportable
  module Create
    module GS
      class Outcome < Sportable::Base
        string :name, :uid, default: nil
        validates :name, :uid, presence: true
        object :market

        def execute
          outcome = market.outcomes.find_or_initialize_by(uid: uid)
          begin
            outcome.update!(inputs.except(:market)) && outcome
            outcome.markets << market

          rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid
            market.outcomes.find_by(uid: uid)
          end
        end
      end
    end
  end
end
