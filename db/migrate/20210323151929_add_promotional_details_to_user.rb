class AddPromotionalDetailsToUser < ActiveRecord::Migration[5.2]
  def change
    %I[upcoming_event_notification promotional_notification
       withdrawal_request_notification
       security_changes_notification].each do |column|
      add_column :users, column, :boolean, default: true
    end
  end
end
