class Api::Users::PromoCodesController < Api::BaseController

  def verify
    outcome = User::PromoCodeVerificationIntr.run(params.except(:promo_code).merge(user: current_user))
    return render_error_response(outcome.errors.full_messages) unless outcome.valid?
    render_success_response(user_response(outcome.result))
  end

protected
  
  def user_response(result)
    msg = I18n.t(message_key(result[:kind]), result)
    result.merge(display_message: msg)
  end

  def message_key(kind)
    if kind == PromoCode::FIXED_VALUE
      'messages.promo_code.display_message.fixed_value'
    else
      'messages.promo_code.display_message.percentage'
    end
  end
end
