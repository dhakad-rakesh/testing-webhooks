class Admin::DeviceIdsController < Admin::BaseController
  skip_load_and_authorize_resource

  def create
    outcome = Firebase::UpdateTopicSubscription.run(device_id_params)
    if outcome.valid?
      session[:current_device_id] = params[:device_id]
      return render_success_response('Device id updated successfully')
    end
    render_error_response(outcome.errors.full_messages)
  end

  protected

  def device_id_params
    params.permit(:device_id, :old_device_id).merge(topic: Constants::ADMIN_NOTIFICATIONS_TOPIC)
  end
end
