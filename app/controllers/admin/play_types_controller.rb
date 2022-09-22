class Admin::PlayTypesController < Admin::BaseController
  before_action :set_play_type, only: %I[show edit update destroy]

  def index
    @play_types = PlayType.all.paginate(page: params[:page])
  end

  def show; end

  def new
    @play_type = PlayType.new
  end

  def edit; end

  def create
    @play_type = PlayType.new(play_type_params)
    respond_to do |format|
      if @play_type.save
        bet_types = BetType.where(id: params.dig(:play_type, :bet_types))
        @play_type.bet_types << bet_types if bet_types.present?
        format.html { redirect_to admin_play_type_path(@play_type), notice: t('success_create', name: 'play_type') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @play_type.update(play_type_params)
        @play_type.bet_types.delete_all
        bet_types = BetType.where(id: params.dig(:play_type, :bet_types))
        @play_type.bet_types << bet_types if bet_types.present?
        format.html { redirect_to admin_play_type_path(@play_type), notice: t('success_update', name: 'play_type') }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @play_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_play_types_path, notice: t('success_destroy', name: 'play_type') }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_play_type
    @play_type = PlayType.find(params[:id]&.to_i)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def play_type_params
    params[:play_type][:bet_types] = params[:play_type][:bet_types].reject(&:blank?)
    params.require(:play_type).permit(:name)
  end
end
