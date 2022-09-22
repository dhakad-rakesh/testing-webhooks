class Admin::DialectsController < Admin::BaseController
  before_action :set_dialect, only: %w[update]
  include Dialects

  def index
    @dialects = Dialect.all.paginate(page: params[:page])
  end

  def create
    Dialect.new(name: params[:dialect][:name]).save
    redirect_to admin_dialects_path
  end

  def update
    return render json: { error: t('not_found', name: t('dialect')) }, status: :not_found unless @dialect
    return render json: { message: dialect_status_message } if @dialect&.update(update_params)
    render json: { error: @dialect.errors.full_messages.first }, status: :bad_request
  end

  private

  def update_params
    params.permit(:enabled)
  end

  def set_dialect
    @dialect = Dialect.find_by(id: params[:id])
  end

  def dialect_status_message
    status = @dialect.enabled ? 'enabled' : 'disabled'

    t(".dialect_#{status}", name: @dialect.name)
  end
end
