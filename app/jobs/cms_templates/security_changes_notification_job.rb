# Every time user Changes security question
module CmsTemplates
  class SecurityChangesNotificationJob < ApplicationJob
    queue_as :low

    def perform
      # CmsTemplate.template_fors.each_keys do |scope|

      # end
    end
  end
end
