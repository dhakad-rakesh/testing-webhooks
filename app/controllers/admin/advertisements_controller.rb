class Admin::AdvertisementsController < Admin::BaseController
  before_action :set_ad, only: %I[update edit show destroy]
  skip_load_resource only: %I[create]

  def index
    @ads = Advertisement.all.order_by_recent.paginate(page: params[:page])
  end

  def new
    @ad = Advertisement.new
  end

  def edit
  end

  def show
  end

  def create
    @ad = Advertisement.new(ad_params)
    if @ad.save
      flash[:notice] = t('success_create', name: t('ad'))
      redirect_to admin_advertisement_path(@ad)
    else
      flash[:error] = @ad.errors.full_messages.join('<br/>')
      render :new
    end
  end

  def update
    @ad.assign_attributes(ad_params)

    if @ad.save
      flash[:notice] = t('success_update', name: t('ad'))
      redirect_to admin_advertisement_path(@ad)
    else
      flash[:error] = @ad.errors.full_messages.to_sentence
      render :edit
      # redirect_to admin_advertisements_path
    end
  end

  def destroy
    if @ad.destroy
      flash[:notice] = t('success_destroy', name: t('ad'))
    else
      flash[:error] = @ad.errors.full_messages.to_sentence
    end
    redirect_to admin_advertisements_path
  end

  private

  def ad_params
    params.require(:advertisement).permit(
      :web_ad_image, :app_ad_image, :enabled, :name, :position, :ad_url, :per_click_cost
    )
  end

  def set_ad
    @ad = Advertisement.find_by(id: params[:id])
    return if @ad.present?
    flash[:error] = t('not_found', name: t('ad'))
    
    redirect_to admin_advertisements_url
  end

end
