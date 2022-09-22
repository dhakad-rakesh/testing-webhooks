class Lsports::AMQP::PrematchListenerWorker < Lsports::AMQP::BaseListenerWorker
  sidekiq_options queue: :amqp_prematch_client, retry: false

  def listener_options
    { inplay: false }
  end

  def listener_key_name
    :amqp_prematch_listener_status
  end

  def mail_subject
    "LS PrematchConnection closed"
  end

  def disabled?
    FeatureTogglers::PrematchRealtimeUpdates::Toggler.deactivated?
  end

  # TODO: Look for something unambiguous
  def objects
    @@objects ||= []
  end
end
