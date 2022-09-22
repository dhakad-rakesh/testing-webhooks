class DeletePlayerOutcomesJob < ApplicationJob
  queue_as :low
  def perform
    DeletePlayerOutcomes.run!(schedule_date: Time.zone.today - Constants::PLAYER_MARKETS_OUTCOMES_EXPIRY_DURATION.days)
  end
end
