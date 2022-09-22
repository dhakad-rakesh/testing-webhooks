class Api::Users::SecurityQuestionsController < Api::BaseController
  skip_before_action :user_authorize!, only: %I[index verify]
  before_action :set_email_user, only: %I[index verify]

  def index
    render json: @user.security_questions.created_at_desc
  end

  def verify
    result = @user.verify_security_answer?(params[:security_question_id], params[:answer])
    render json: { result: result }, status: result ? 200 : 400
  end

  private

  def set_email_user
    @user = User.where(email: params[:email]&.downcase).first
    render_not_found_response('User not found') unless @user
  end
end
