class Admin::PopupsController < Admin::BaseController
  before_action :set_popup, only: %I[update edit]
  before_action :set_live_popup_ids, only: %I[index]
  
  def index
    @popups = Popup.order_by_recent
    # filter_popups if query.present?
    @popups = @popups.paginate(page: params[:page], per_page: Constants::PER_PAGE)
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # def filter_popups
  #   @popups = @popups.where(id: query[:promo_id]) if query[:promo_id].present?
  #   @popups = @popups.where('name ILIKE ?', "%#{query[:name].strip}%") if query[:name].present?
  #   @popups = @popups.between(query[:start_date], query[:end_date]) if query[:filter_date].present?
  #   @popups = @popups.where('code ILIKE ?', "%#{query[:popup].strip}%") if query[:popup].present?
  #   @popups = @popups.send(query[:promo_status]) if query[:promo_status].present?
  #   @popups = @popups.send(query[:promo_kind]) if query[:promo_kind].present?
  #   @popups = @popups.expiring_between(query[:start_valid_date], query[:end_valid_date]) if query[:valid_till_date].present?
  # end

  def new
    @popup = Popup.new
  end

  def edit; end

  def create
    @popup = Popup.new(popup_params)
    if @popup.save
      flash[:notice] = t('success_create', name: t('popup'))
      redirect_to admin_popups_path
    else
      flash[:error] = @popup.errors.full_messages.join("<br/>")
      render :new
    end
  end

  def update
    @popup.assign_attributes(popup_params)

    if @popup.save
      flash[:notice] = t('success_update', name: t('popup'))
      redirect_to admin_popups_path
    else
      flash[:error] = @popup.errors.full_messages.join("<br/>")
      render :new
    end
  end

  private

  def set_live_popup_ids
    @live_popup_ids = Popup.live_now.pluck :id
  end

  def popup_params
    params.require(:popup).permit(:name, :title, :screen, :platform, :repeat_type,
      :repeat_duration, :link, :redirection, :start_date, :end_date, :status,
      :structure, country_ids: [])
  end

  def set_popup
    @popup = Popup.find_by(id: params[:id])
    return if @popup.present?
    flash.now[:error] = "Popup record unavailable"

    render :index
  end

  def query
    @query ||= params[:query]
  end
end