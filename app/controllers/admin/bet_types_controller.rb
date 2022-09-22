class Admin::BetTypesController < Admin::BaseController
  load_and_authorize_resource

  def index
    @bet_types = BetType.all.paginate(page: params[:page])
  end

  def show; end

  def new; end

  def edit; end

  def create
    @bet_type = BetType.new(bet_type_params)
    respond_to do |format|
      if @bet_type.save
        play_types = PlayType.where(id: params.dig(:bet_type, :play_types))
        @bet_type.play_types << play_types if play_types.present?
        format.html { redirect_to admin_bet_type_path(@bet_type), notice: t('success_create', name: t('bet_type')) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @bet_type.update(bet_type_params)
        @bet_type.play_types.delete_all
        play_types = PlayType.where(id: params.dig(:bet_type, :play_types))
        @bet_type.play_types << play_types if play_types.present?
        format.html { redirect_to admin_bet_type_path(@bet_type), notice: t('success_update', name: t('bet_type')) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @bet_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_bet_types_path, notice: t('success_destroy', name: t('bet_type')) }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def bet_type_params
    params[:bet_type][:play_types] = params[:bet_type][:play_types].reject(&:blank?)
    params.require(:bet_type).permit(:name)
  end
end
