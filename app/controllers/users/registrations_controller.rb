class Users::RegistrationsController < Devise::RegistrationsController
  layout "user_theme"
  def new
    super
  end

  def create
    build_resource(sign_up_params)
    resource.save# if verify_recaptcha(model: resource)

    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      resource.errors.full_messages.each { |x| flash[:error] = x }
      # respond_with resource
      render :new
    end
  end

  def update
    super
  end
end 