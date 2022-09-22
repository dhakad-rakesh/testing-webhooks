module Translations
  class SportScheduleTranslationsJob < ApplicationJob
    queue_as :low

    def perform(sport_uid:, locale: 'en')
      params = { locale: locale.to_sym, sport_uid: sport_uid }
      FeedData::Driver.run!(action: action, mapper: mapper, params: params)
    end

  protected

    def action
      Translations::UpdateScheduleJob
    end

    def mapper
      FeedData::Lsports::Mappers::Translations::Schedule
    end
  end
end
