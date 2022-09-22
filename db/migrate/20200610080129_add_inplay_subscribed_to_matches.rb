class AddInplaySubscribedToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :inplay_subscribed, :boolean, default: false
  end
end
