module LS
  class MonitorScheduleMatch < ScheduleMatch
    private

    def client
      @client ||= Lsports::Client.new(sport: sport, params: schedule_between)
    end

    def schedule_between
      from_date = (Time.zone.now - 30.minutes).to_i
      to_date = (Time.zone.now.end_of_day).to_i

      { FromDate: from_date, ToDate: to_date }
    end
  end
end