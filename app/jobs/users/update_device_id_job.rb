class Users::UpdateDeviceIdJob < ApplicationJob
  queue_as :low

  def perform(user_id, device_id: nil, old_device_id: nil)
    user = User.find_by(id: user_id)
    return unless user
    device_params = { user: user, device_id: device_id, old_device_id: old_device_id }.compact
    Firebase::UpdateDeviceId.run!(device_params)
  end
end
