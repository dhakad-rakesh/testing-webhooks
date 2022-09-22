class Admin::LanguagesController < Admin::BaseController
  before_action :set_language, only: %w[toggle_enabled]

  def toggle_enabled
    @language.toggle!(:enabled)
  end
  # include Languages
  # def index
  #   @languages = Language.all
  #   @languages = @languages.paginate(page: params[:page])
  # end

  # def create
  #   Language.new(name: params[:language][:name]).save
  #   redirect_to admin_languages_path
  # end

  # def update
  #   return render json: { error: t('not_found', name: t('language')) }, status: :not_found unless @language
  #   return render json: { message: language_status_message } if @language&.update(update_params)
  #   render json: { error: @language.errors.full_messages.first }, status: :bad_request
  # end

  # private

  # def update_params
  #   params.permit(:enabled)
  # end

  def set_language
    @language = Language.find_by(id: params[:id])
  end

  # def language_status_message
  #   status = @language.enabled ? 'enabled' : 'disabled'
    
  #   t(".language_#{status}", name: @language.name)
  # end
end
