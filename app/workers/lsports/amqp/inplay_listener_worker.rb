class Lsports::AMQP::InplayListenerWorker < Lsports::AMQP::BaseListenerWorker
  sidekiq_options queue: :amqp_client, retry: false

  def listener_options
    { inplay: true }
  end

  def listener_key_name
    :amqp_listener_status
  end

  def mail_subject
    "LS InplayConnection closed"
  end

  def objects
    @@objects ||= []
  end
end
