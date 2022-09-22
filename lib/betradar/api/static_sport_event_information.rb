module Api
  module StaticSportEventInformation
    # Fixture for a specified sport event
    def fixture(event_id, event_type = 'sr:match')
      get("sports/en/sport_events/#{event_type}:#{event_id}/fixture.xml")
    end

    # All sport events for a specific date
    def schedules(schedule_date = nil)
      schedule_date ||= Time.zone.today
      schedule_date = Time.zone.parse(schedule_date.to_s).to_date.to_s
      get("sports/en/schedules/#{schedule_date}/schedule.xml")
    end

    # Currently live sport events
    def live_schedule
      get('sports/en/schedules/live/schedule.xml')
    end

    # Schedule for a tournament
    def tournament_schedule(tournament_uid)
      get("sports/en/tournaments/#{tournament_uid}/schedule.xml")
    end

    # Lists the IDs of all fixtures that have changed in the last 24 hours.
    def fixture_changes
      get('sports/en/fixtures/changes.xml')
    end
  end
end
