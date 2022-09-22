class ScheduleMatchesJob < ApplicationJob
  queue_as :low

  def perform(*args)
    kind = args.first

    sports.each do |sport|
      if kind == 'monitor'
        LS::MonitorScheduleMatch.run!(sport: sport, kind: kind)
      else
        LS::ScheduleMatch.run!(sport: sport)
      end
    end
  end

  private

  def sports
    Sport.sports.active_sports
  end
end
