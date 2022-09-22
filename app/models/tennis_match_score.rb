class TennisMatchScore < ApplicationRecord
  belongs_to :match
  include Scoreable
end
