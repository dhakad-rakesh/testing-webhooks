class AddBookingStatusToMatch < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :booking_status, :string
  end
end
