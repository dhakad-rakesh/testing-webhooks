# WeeklyCron to update tournament weekly
class WeeklyCron < ActiveInteraction::Base
  def execute
    CategoriseTournamentsJob.perform_later
  end
end
