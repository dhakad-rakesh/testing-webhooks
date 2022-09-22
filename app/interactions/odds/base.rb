module Odds
  class Base < ApplicationInteraction
    include Betradar::MarketOddsUtil
  end
end
