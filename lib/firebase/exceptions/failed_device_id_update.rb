class Firebase::Exceptions::FailedDeviceIdUpdate < ::StandardError
  def initialize(msg)
    @message = msg
    super
  end

  def message
    @message ||= I18n.t('users.device_id.update.failed')
  end
end
