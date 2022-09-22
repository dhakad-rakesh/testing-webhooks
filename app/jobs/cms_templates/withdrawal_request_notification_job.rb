# Every time user made withdrawal request
module CmsTemplates
  class WithdrawalRequestNotificationJob < ApplicationJob
    queue_as :low

    def perform
      # CmsTemplate.template_fors.each_keys do |scope|

      # end
    end
  end
end
