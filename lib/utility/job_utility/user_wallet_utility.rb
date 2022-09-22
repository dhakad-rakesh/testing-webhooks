module Utility::JobUtility::UserWalletUtility
  def publish_data(data, user_id, channel_name = Constants::WALLET_UPDATE_CHANNEL)
    Firebase::PublishData.run!(
      channel_name: "#{channel_name}/#{user_id}", data: data
    )
  rescue ::StandardError => e
    custom_error_logger(e)
  end

  def custom_error_logger(exception)
    Honeybadger.notify(
      "[Firebase Error] : [#{exception.class}] : [#{exception.cause}]",
      class_name: exception.class
    )
  end
end