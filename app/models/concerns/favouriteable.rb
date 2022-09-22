# This module will allow user to add other objects as favourite
module Favouriteable
  extend ActiveSupport::Concern
  included do
    has_many :favourites, as: :favouriteable, dependent: :destroy
  end
end
