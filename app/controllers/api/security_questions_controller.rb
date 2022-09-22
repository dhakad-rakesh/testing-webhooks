class Api::SecurityQuestionsController < Api::BaseController
  skip_before_action :user_authorize!, only: %I[index]

  def index
    render_collection(
      SecurityQuestion.enabled.created_at_desc.paginate(
        page: params[:page], per_page: params[:per_page]
      )
    )
  end
end
