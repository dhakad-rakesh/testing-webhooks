# DailyCron to update daily matches and markets
class DailyCron < ActiveInteraction::Base
  def execute
    ScheduleMatchesJob.perform_later
    Sportable::Feed::GS::MarketListJob.perform_later
    DeletePlayerOutcomesJob.perform_later
  end
end
