module Translations
  class UpdateScheduleJob < ApplicationJob
    queue_as :low

    def perform(data:, locale: 'en')
      Translations::UpdateSchedule.run!(data: data.with_indifferent_access, locale: locale.to_sym)
    end
  end
end
