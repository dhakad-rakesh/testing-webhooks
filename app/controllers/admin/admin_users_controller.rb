include LedgersHelper
class Admin::AdminUsersController < Admin::BaseController
  #for cancan
  load_and_authorize_resource
  before_action :set_admin_user, only: %I[index show update edit destroy enable_disable_user update_commision_settings]
  before_action :admin_report, only: %I[show]
  # before_action :set_resellers, only: %I[index search]
  before_action :set_affiliates, only: %I[index search]
  before_action :set_redirect_url, only: %I[enable_disable_user destroy]

  def index
    @users = @users.order_by_recent.paginate(page: params[:page])
  end

  def new
    @user = AdminUser.new
  end

  def edit; end

  def show; end

  def create
    @user = AdminUser.new(admin_user_params)
    @user.add_role 'sub_admin'
    #@user.skip_confirmation!
    #@user.confirm
    if @user.save
      # url = params[:role] == 'sub_admin' ? admin_admin_users_path(role: 'sub_admin') : admin_admin_users_path
      NotificationMailer.affiliate_link(@user).deliver_later
      url = admin_admin_users_path
      flash[:notice] = t('success_create', name: t('user'))
      redirect_to url
    else
      flash[:error] = @user.errors.full_messages.join('<br/>')
      render :new
    end
  end

  def update
    bypass_blank_password
    @user.assign_attributes(admin_user_params)
    #@user.skip_confirmation!
    #@user.confirm
    if @user.save
      flash[:notice] = t('success_update', name: t('user'))
      redirect_to admin_admin_user_path(@user)
    else
      flash[:error] = @user.errors.full_messages.join('\n')
      redirect_to admin_admin_users_path
    end
  end

  # def enable_disable_user
  #   @user.toggle :enable
  #   if @user.save(validate: false)
  #     flash[:notice] = t('success_update', name: t('user'))
  #   else
  #     flash[:error] = @user.errors.full_messages.join('\n')
  #   end
  #   redirect_to @url
  # end

  def enable_disable_user
    @user.undiscarded? ? @user.discard : @user.undiscard

    if @user.save(validate: false)
      flash[:notice] = t('success_update', name: t('user'))
    else
      flash[:error] = @user.errors.full_messages.join('\n')
    end
    redirect_to @url
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to @url, notice: t('success_destroy', name: t('resellers.reseller')) }
      else
        format.html { render :show, notice: t('went_wrong') }
      end
    end
  end

  def search
    @users = @users.search(params[:query]) if params[:query].present?
    @users = @users.search_by_amount(params[:amt_type], params[:min_amt].to_f, params[:max_amt].to_f) if params[:min_amt].present? && params[:max_amt].present?
    @users = @users.order(id: :desc)
                   .paginate(page: params[:page]) || []
    return render :index if params[:page].present?
    respond_to do |format|
      format.js
    end
  end

  def admin_user_params
    params.require(:admin_user).permit(:email, :first_name, :last_name, :reseller_percentage, :password, :password_confirmation, :status, :admin_user_id, :sub_admin_user_id, :label, :reciever_address)
  end

  def update_commision_settings
    @user.assign_attributes(commision_params)

    if @user.save
      render js: "toastr.success('Commision updated successfully')"
    else
      render js: "toastr.error('#{@user.errors.full_messages.join('\n')}')"
    end
  end

  private


  def admin_report
    @ledgers = @user.current_wallet.ledgers
    @credited_amount = @ledgers.credit.sum(:amount).to_f
    @user_wegered_amount = @user.affiliate_stats[:wagered_amount]
    @due_wegered_amount = @user_wegered_amount - @user.current_wallet.wagered_amount
    @payout_percentage = reseller_percentage_calc(@due_wegered_amount, @user)
    @due_amount = @due_wegered_amount * @payout_percentage / 100
  end

  def commision_params
    commision_params = { commision: {} }
    %i[range_1 range_2 range_3].each do |sym|
      if params[:commision][sym].present?
        commision_params[:commision][sym] = {}
        %i[amount percentage].each do |attribute|
          commision_params[:commision][sym][attribute] = params[:commision][sym][attribute].to_i
        end
      end
    end
    commision_params[:commision][:enabled] = params[:commision][:enabled]
    commision_params
  end


  def bypass_blank_password
    if params[:admin_user][:password].blank? && params[:admin_user][:password_confirmation].blank?
      params[:admin_user].delete(:password)
      params[:admin_user].delete(:password_confirmation)
    end
  end

  def set_admin_user
    admin_user_id = params[:id] || params[:admin_user_id]
    @user = AdminUser.find_by(id: admin_user_id)
    return if admin_user_id.blank?
    if @user.present?
      return if current_admin_user.is_super_admin?
      return if @user.id.eql?(current_admin_user.id)
    end
    flash[:error] = I18n.t('user.not_found')
    redirect_to admin_admin_users_url
  end

  def set_resellers
    if @user.present?
      @users = @user.resellers
    elsif current_admin_user.is_reseller?
      @users = current_admin_user.resellers
    elsif params[:role] == 'sub_admin'
      @users = current_admin_user.sub_admins
    else
      @users = AdminUser.where(sub_admin_user_id: nil)
    end
  end

  def set_affiliates
    @users = current_admin_user.sub_admins
  end

  def set_redirect_url
    # @url = @user.roles.first.name == 'sub_admin' ? admin_admin_users_path(role: 'sub_admin') : admin_admin_users_path
    @url = admin_admin_users_path
  end
end
