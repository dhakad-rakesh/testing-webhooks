module CmsTemplates
  class DailyNotificationsJob < ApplicationJob
    queue_as :low

    def perform
    end
  end
end
