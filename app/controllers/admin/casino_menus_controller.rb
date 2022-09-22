class Admin::CasinoMenusController < Admin::BaseController
  before_action :set_casino_menu, only: %i[edit show update toggle_featured_status]

  def index
    @casino_menus = CasinoMenu.order(:menu_order).paginate(page: params[:page])
  end

  def new
    @casino_menu = CasinoMenu.new
  end

  def create
    @casino_menu = CasinoMenu.new(casino_menu_params)
    @casino_menu.menu_order = CasinoMenu.count + 1

    if @casino_menu.save
      flash[:notice] = t('success_create', name: t('casino.menu'))
      redirect_to admin_casino_menus_path
    else
      flash[:error] = @casino_menu.errors.full_messages.join('<br/>')
      render :new
    end
  end

  def update
    if @casino_menu.update(casino_menu_params)
      flash[:notice] = t('success_update', name: t('casino.menu'))
      redirect_to admin_casino_menus_path
    else
      flash[:error] = @casino_menu.errors.full_messages.join('<br/>')
      render :edit
    end
  end

  def change_menus_order
    params[:sorted_ids].each_with_index do |id, index|
      casino_menu = CasinoMenu.find_by(id: id&.to_i)
      casino_menu.update(menu_order: index + 1)
    end
    render json: { message: 'Order updated successfully.' }
  end

  def toggle_featured_status
    @casino_menu.toggle!(:is_featured)
  end

  private

  def casino_menu_params
    params.require(:casino_menu).permit(:name, :menu_type, :menu_order, :enabled)
  end

  def set_casino_menu
    @casino_menu = CasinoMenu.find(params[:id])
  end
end
