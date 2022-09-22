module Api
  # Book a match for liveodds coverage.
  module BookingCalendar
    # Book a match for liveodds coverage
    def liveodds_coverage(match_id)
      post("liveodds/booking-calendar/events/#{match_id}/book")
    end
  end
end
