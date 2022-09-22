class CmsTemplate < ApplicationRecord
  enum template_for: { upcoming_event_notification: 0,
                       promotional_notification: 1,
                       # withdrawal_request_notification: 2,
                       # security_changes_notification: 3,
                       # special_day_notification: 4,
                       site_maintenance_notification: 5,
                       # highlight_match_notification: 6,
                       active_user_notification: 7,
                       inactive_user_notification: 8 
                     }

  def allowed_send_now?
    active_user_notification? || inactive_user_notification? || promotional_notification?
  end
end
