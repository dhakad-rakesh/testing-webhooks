class DeletePlayerOutcomes < ApplicationInteraction
  date :schedule_date

  def execute
    # Select matches whose player outcomes have to be deleted
    matches = Match.where('schedule_at > ? AND schedule_at < ?',
      schedule_date.beginning_of_day, schedule_date.end_of_day)
    variants = matches.map { |match| "pre:playerprops:#{match.uid.scan(/\d+/)&.first}%" }
    # Destroy all outcomes where uid contains event id of match
    Outcome.where('uid like ANY (array [?])', variants).destroy_all
  end
end
