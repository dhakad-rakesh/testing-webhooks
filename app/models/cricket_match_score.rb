class CricketMatchScore < ApplicationRecord
  belongs_to :match
  include Scoreable
end
