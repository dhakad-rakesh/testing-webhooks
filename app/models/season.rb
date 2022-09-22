class Season < ApplicationRecord
  validates :uid, uniqueness: true
  belongs_to :sport
  belongs_to :tournament
  has_many :matches, dependent: :destroy
end
