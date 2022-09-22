module Sportable
  module Create
    module GS
      class Market < Sportable::Base
        string :name, :uid, default: nil
        validates :name, :uid, presence: true

        def execute
          market = ::Market.find_or_initialize_by(uid: uid)
          begin
            market.update!(inputs) && market
          rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid
            ::Market.find_by(uid: uid)
          end
        end
      end
    end
  end
end
