class Api::Users::DeviceIdsController < Api::BaseController

  def create
    outcome = Firebase::UpdateDeviceId.run(device_id_params)
    return render_success_response('Device id added successfully') if outcome.valid?
    render_error_response(outcome.errors.full_messages)
  end

  protected

  def device_id_params
    params.permit(:device_id, :old_device_id).merge(user: current_user)
  end
end
