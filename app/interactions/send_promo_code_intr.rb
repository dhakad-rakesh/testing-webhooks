class SendPromoCodeIntr < ApplicationInteraction
  object :promo_code
  boolean :broadcast, default: false
  array :user_ids, default: []

  set_callback :type_check, :after, :validate_receiver

  def execute
    if broadcast
      broadcast_notification      
    else
      user_ids.each do |id|
        send_to_user(id)
      end
    end
  end

  def broadcast_notification
    job.perform_later(*notification_params, { broadcast: true })
  end

  def send_to_user(id)
    job.perform_later(*notification_params, { user_id: id })
  end

  def job
    Notifications::PublishNotificationJob
  end

  def notification_params
    [promo_code.id, Constants::NOTIFICATION_KIND[:promo_code]]
  end

  def validate_receiver
    return if broadcast || user_ids.present?
    errors.add(:base, I18n.t('errors.messages.notifications.invalid_receiver'))
  end
end
