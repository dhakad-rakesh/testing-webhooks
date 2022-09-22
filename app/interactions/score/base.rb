# Soccer module
module Score
  # Base class for all soccer interaction.
  # This class will be inheritated by all other soccer classes
  class Base < ApplicationInteraction
    hash :sport_event_status, strip: false
    object :match
    # 1. Put all score related attributes in score_attributes after whitelisting
    # attributes
    # 2. sport_type is used to have name of sport in underscore form.
    # We use this to find which score_attributes need to call
    attr_accessor :score_attributes, :sport_type
  end
end
