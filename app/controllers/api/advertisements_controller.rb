class Api::AdvertisementsController < Api::SkipAuthenticationController

  def index
    @ads = Advertisement.enabled.order_by_recent.paginate(page: params[:page], per_page: params[:per_page])
    render_collection(@ads)
  end

  def ad_visits
    @ad = Advertisement.find_by(id: params[:id])
    return render_error_response('Ad not found') unless @ad
    @ad.increment!(:click_count)
    render_success_response('Ad Visit count added successfuly')
 end
end
