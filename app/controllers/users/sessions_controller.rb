class Users::SessionsController < Devise::SessionsController
  layout "user_theme"

  def new
    redirect_to root_path   
  end
end
