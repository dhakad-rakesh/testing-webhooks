class Admin::SecurityQuestionsController < Admin::BaseController
  before_action :set_security_question, only: %I[update destroy]

  def index
    @security_questions = SecurityQuestion.created_at_desc.paginate(page: params[:page])
  end

  def create
    security_question = SecurityQuestion.new(security_question_params)
    if security_question.save
      flash[:success] = t('success_create', name: 'security_ques')
    else
      flash[:error] = t('went_wrong')
    end
    redirect_to admin_security_questions_path
  end

  def update
    return render json: { error: t('not_found'), name: t('question') }, status: :not_found unless @security_question
    return render json: { message: security_question_status_message } if @security_question&.update(update_params)
    render json: { error: @security_question.errors.full_messages.first }, status: :bad_request
  end

  def destroy
    if @security_question&.destroy
      flash[:success] = t('success_destroy', name: 'question')
    else
      flash[:error] = t('went_wrong')
    end
    redirect_to admin_security_questions_path
  end

  private

  def set_security_question
    @security_question = SecurityQuestion.find_by(id: params[:id])
  end

  def update_params
    params.permit(:enabled)
  end

  def security_question_status_message
    status = @security_question.enabled ? 'enabled' : 'disabled'

    t(".message_#{status}", question_id: @security_question.id)
  end

  def security_question_params
    params.require(:security_question).permit(:question)
  end
end
