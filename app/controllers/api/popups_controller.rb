class Api::PopupsController < Api::BaseController
  def index
    popups = Popup.by_country_id(user_country_id).live_now
    
    serialized_popups = popups.map { |popup| PopupSerializer.new(popup) }
    render json: { popups: serialized_popups, first_login: current_user.first_login? }
  end

  private
  
  def user_country_id
    current_user.country_id
  end
end