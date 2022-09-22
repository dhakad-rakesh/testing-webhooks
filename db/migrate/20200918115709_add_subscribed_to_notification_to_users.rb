class AddSubscribedToNotificationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :subscribed_to_notifications, :boolean, default: true
  end
end
