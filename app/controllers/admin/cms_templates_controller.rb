class Admin::CmsTemplatesController < Admin::BaseController
  # skip_load_and_authorize_resource
  before_action :intialize_cms_template, only: [:send_now, :destroy]

  def index
    # @cms_templates = CmsTemplate.all
    @cms_templates = @cms_templates.paginate(page: params[:page], per_page: Constants::PER_PAGE)
  end

  def create
    if @cms_template.save
      url = params[:role] == 'sub_admin' ? admin_cms_template_path(role: 'sub_admin') : admin_cms_templates_path
      flash[:notice] = t('success_create', name: t('cms'))
      redirect_to url
    else
      flash[:error] = @user.errors.full_messages.join('<br/>')
      render :new
    end
  end

  def show; end

  def update
    @cms_template.assign_attributes(cms_template_params)
    if @cms_template.save
      url = params[:role] == 'sub_admin' ? admin_cms_template_path(role: 'sub_admin') : admin_cms_templates_path
      flash[:notice] = t('success_create', name: t('cms'))
      redirect_to url
    else
      flash[:error] = @user.errors.full_messages.join('<br/>')
      render :edit
    end
  end

  def promotion_notification
    user_ids = params[:user_ids].split(',')
    CmsTemplates::PromotionalNotificationJob.perform_later(params[:cms_template_id], user_ids)
    flash[:notice] = t('success_update', name: t('user'))
    redirect_to admin_users_path
  end

  def send_now
    if @cms_template.allowed_send_now? 
      if @cms_template.active_user_notification?
        CmsTemplates::ActiveUserNotificationsJob.perform_later(@cms_template.id)
      elsif @cms_template.inactive_user_notification?
        CmsTemplates::InactiveUserNotificationsJob.perform_later(@cms_template.id)
      elsif @cms_template.promotional_notification?
        CmsTemplates::PromotionalNotificationJob.perform_later(@cms_template.id, [], true)
      end
      flash[:notice] = "Notification will be send to users."
    else
      flash[:error] = "Can't send this template."
    end
    redirect_to admin_cms_templates_path
  end

  def destroy
    @cms_template.destroy ? ( flash[:notice] = "Template Deleted!" ) : ( flash[:error] = "Error while deleting template" )
    redirect_to admin_cms_templates_path
  end

  private

  def cms_template_params
    params.require(:cms_template).permit(
      :subject,
      :content,
      :schedule_at,
      :template_for
    )
  end

  def intialize_cms_template
    @cms_template = CmsTemplate.find_by(id: params[:id])
    if @cms_template.blank?
      flash[:error] = "Template Not Found."
      redirect_to admin_cms_templates_path
    end
  end
end
