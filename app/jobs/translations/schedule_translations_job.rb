module Translations
  class ScheduleTranslationsJob < ApplicationJob
    queue_as :low

    def perform(locale)
      sports.pluck(:uid).each do |uid|
        action.perform_later(sport_uid: uid, locale: locale)
      end
    end

  protected

    def sports
      Sport.sports.active_sports
    end

    def action
      Translations::SportScheduleTranslationsJob
    end
  end
end
