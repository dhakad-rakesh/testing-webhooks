class AddOtpInUserTable < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :otp, :string
    add_column :users, :otp_created_at, :datetime
  end
end
