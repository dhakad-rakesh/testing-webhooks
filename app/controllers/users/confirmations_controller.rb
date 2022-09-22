class Users::ConfirmationsController < Devise::ConfirmationsController
  layout "user_theme"

  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_navigational_format?
      respond_with_navigational(resource){ redirect_to root_path }
    else
      respond_with_navigational(resource.errors, :status => :unprocessable_entity){ render_with_scope :new }
    end
  end
end
