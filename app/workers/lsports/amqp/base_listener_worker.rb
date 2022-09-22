class Lsports::AMQP::BaseListenerWorker
  include Sidekiq::Worker

  def perform
    # Inplay queue should not be listene on rails end.
    return if disabled? || is_inplay? || connection_established? 

    listener = LS::AMQP::Listener.run!(listener_options)
    objects << listener

    size = objects.size

    Rails.logger.info "==========objects size #{objects.size}=================="
    return if size == 1

    objects.each_with_index do |value, i|
      i == (size - 1) ? (objects = [listener]) : value.try(:close) # rubocop:disable Style/ClassVars
    end
  end

  def connection_established?
    amqp_listener_status = Rails.cache.read(listener_key_name)
    # Check if LS connection is active.
    return true if amqp_listener_status.present? && amqp_listener_status == :open

    if amqp_listener_status.present?
      AmqpClientErrorMailer.client_error(
        Figaro.env.developers_mail, mail_subject, "Connection Status #{amqp_listener_status}",
        Time.zone.now.to_s
      ).deliver_later
    end

    false
  end

  def listener_options
    raise NotImplementedError
  end

  def listener_key_name
    raise NotImplementedError
  end

  def mail_subject
    raise NotImplementedError
  end

  def disabled?
    false
  end

  def objects
    raise NotImplementedError
  end

  def is_inplay?
    listener_options[:inplay] == true
  end
end
