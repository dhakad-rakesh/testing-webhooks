class MatchBookingJob < ApplicationJob
  def perform(match_id)
    match = Match.find(match_id)
    status =
      supervise_api_access do
        client.liveodds_coverage(match.uid).with_indifferent_access
      end
    return if status == true
    return unless status.dig(:response, :response_code) == 'OK' && status.dig(:response, :message) == 'OK.'
    match.update(booking_status: 'booked')
  end

  private

  def supervise_api_access
    yield
  rescue ::StandardError => exception
    return custom_error_logger(exception) if exception.is_a?(Betradar::Error::BadRequest)
    raise exception
  end

  def client
    @client ||= Betradar::Client.new
  end

  def custom_error_logger(exception)
    Honeybadger.notify(
      "[AMQP Listner Error] : [#{exception.class}] : [#{exception.cause}]",
      class_name: exception.class
    )
  end
end
