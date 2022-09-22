class Admin::CasinoController < Admin::BaseController
  before_action :set_casino_item, only: %i[update_casino_item update_menu_for_casino_item]

  def index
    @casino_items = fetch_casino_items
    @casino_menus = CasinoMenu.enabled.order(:menu_order)
    @item_types = CasinoItem.pluck(:item_type).uniq
    @providers = CasinoItem.pluck(:provider).uniq
  end

  def update_menu_for_casino_item
    @casino_item.update_column(:casino_menu_id, params[:menu_id])
    render json: { message: 'Menu updated successfully.' }
  end

  def update_casino_item
    return render json: { message: item_status_message } if @casino_item.update(update_params)

    render json: { error: @casino_item.errors.full_messages.first }, status: :bad_request
  end

  private

  def fetch_casino_items
    casino_items = CasinoItem.all
    casino_items = casino_items.assigned_to_menus(nil) if params[:menu] == 'un-assigned'
    casino_items = casino_items.assigned_to_menus(params[:menu]) if params[:menu] && params[:menu] != 'un-assigned'
    casino_items = casino_items.item_types(params[:item_type]) if params[:item_type].present?
    casino_items = casino_items.providers(params[:provider]) if params[:provider].present?
    casino_items = casino_items.search_by(params[:query]) if params[:query].present?
    casino_items.paginate(page: params[:page])
  end

  def update_params
    params.permit(:active)
  end

  def set_casino_item
    @casino_item = CasinoItem.find_by(id: params[:item_id])
    return render json: { error: t('not_found', name: t('casino.item')) }, status: :not_found unless @casino_item
  end

  def item_status_message
    status = @casino_item.active ? 'enabled' : 'disabled'

    t(".message_#{status}", name: @casino_item.name)
  end
end
