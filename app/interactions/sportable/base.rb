# Soccer module
module Sportable
  # Base class for all soccer interaction.
  # This class will be inheritated by all other soccer classes
  class Base < ApplicationInteraction
    def sport_type
      'Soccer'
    end
  end
end
