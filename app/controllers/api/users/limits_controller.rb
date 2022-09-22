# Handles current user's limits.
class Api::Users::LimitsController < Api::BaseController
  LIMIT_TYPES = %w[timeout_limit reality_check_limit].freeze
  before_action :set_user_limit, only: %I[show]
  after_action :sign_out_user,only: %I[update]
  # skip_before_action :check_country_status

  def update
    outcome = User::UpdateLimitsIntr.run(params.merge(user: current_user))
    return render_error_response(outcome.errors.full_messages) unless outcome.valid?
    render_success_response(t('user_limit.success'))
  end

  def show
    return render_not_found_response(t('user_limit.not_set')) unless @user_limit.present?

    render json: @user_limit
  end

  private

  def set_user_limit
    @user_limit = current_user.current_limits
  end

  def sign_out_user
    return unless current_user.exclusion_time &.> Time.zone.now

    sign_out current_user
    doorkeeper_token.destroy
  end
end

