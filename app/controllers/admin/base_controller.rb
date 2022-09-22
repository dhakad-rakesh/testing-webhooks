class Admin::BaseController < ApplicationController
  before_action :authenticate_admin_user!
  load_and_authorize_resource
  layout 'admin_application'

  def check_status
    if current_admin_user.has_role?(:reseller) && !current_admin_user.status
      flash[:error] = t('errors.messages.reseller_disable')
      redirect_to admin_dashboard_index_path
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to admin_dashboard_index_url, notice: exception.message }
      format.js { head :forbidden, content_type: 'text/html' }
    end
  end
end
