class UpdateUserWalletJob < ApplicationJob
  queue_as :wallet_update
  include Utility::JobUtility::UserWalletUtility

  def perform(data, user_id)
    publish_data(data, user_id)
  end
end
