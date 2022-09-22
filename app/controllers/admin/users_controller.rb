class Admin::UsersController < Admin::BaseController
  #for cancan
  load_and_authorize_resource
  before_action :set_user, only: %I[show update edit stats update_kyc_status get_player_kpis update_sport_visibility]
  before_action :set_users, only: %I[index search]
  before_action :set_sports
  before_action :check_status, only: [:index, :edit, :new]
  before_action :set_wallet, only: [:edit, :update]
  
  skip_load_and_authorize_resource only: [:search]

  def index
    @users = @users.joins(:wallets)
                   .where('wallets.wallet_type': 'point')
                   .order('users.created_at desc')
                   .paginate(page: params[:page], per_page: Constants::PER_PAGE)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    password = generate_random_password
    @user = User.new(password: password, password_confirmation: password)
  end

  def edit; end

  def show; end

  def create
    @user = User.new(user_params)
    @user.user_created_by_admin = true
    if @user.save
      flash[:notice] = t('success_create', name: t('user'))
      redirect_to admin_user_path(@user)
    else
      flash[:error] = @user.errors.full_messages.join("<br/>")
      render :new
    # @user.phone = user_phone
    # @user.skip_confirmation!
    # @user.confirm
    # @user.complete_sign_up
    # User.transaction do
    #   binding.pry
      # @user.create_currency_wallet!(params[:currency])
  #   end
  # rescue StandardError => e
  #   flash[:error] = @user.errors.full_messages.join("<br/>")
  #   render :new
    end
  end

  def stats
    @user.bets.destroy_all
    @user.accumulator_bets.destroy_all
  end

  def update
    @user.assign_attributes((user_params[:password] == "") ? user_params.except(:password) : user_params)
    # update_phone_number
    # @user.skip_confirmation!
    # @user.skip_reconfirmation!
    # @user.confirm
    @user.user_created_by_admin = true
    # @user.complete_sign_up
    if @user.save
      flash.now[:notice] = t('success_update', name: t('user'))
      # redirect_to admin_user_path(@user)
    else
      flash.now[:error] = @user.errors.full_messages.join("<br/>")
      # redirect_to admin_users_path
    end
    render :show
  end

  def enable_disable_user
    @user.undiscarded? ? @user.discard : @user.undiscard
    @user.enabled_by = @user.undiscarded? ? :admin : nil

    @user.save(validate: false)
    respond_to do |format|
      format.js
    end
  end

  def update_kyc_status
    @user.assign_attributes(user_params)
    if @user.save
      NotificationMailer.kyc_request_status(@user).deliver_later if @user.kyc_approved_or_rejected?
      return success_response
    end
    error_response
  end

  def search
    @users = @users.where("user_number ILIKE ?", "%#{params[:id].strip}%") if params[:id].present?
    @users = @users.search(params[:query].strip) if params[:query].present?
    @users = @users.between(params[:reg_start_date], params[:reg_end_date]) if params[:registration_date].present?
    @users = @users.signed_in_between(params[:last_sign_in_start_date], params[:last_sign_in_end_date]) if params[:last_sign_in_at].present?
    @users = @users.search_by_amount(params[:min_amt].to_f, params[:max_amt].to_f) if params[:min_amt].present? && params[:max_amt].present?
    @users = @users.search_by_email(params[:user_email]) if params[:user_email].present?
    if params[:email_status].present? &&  params[:email_status] == "verified"
      @users = @users.email_confirmed_users
    elsif params[:email_status].present? &&  params[:email_status] == "verification_pending"
      @users = @users.email_unconfirmed_users
    end
    # @users = @users.where("phone LIKE ?", "%#{params[:phone].strip}%") if params[:phone].present?
    # @users = @users.joins(:wallets).where('wallets.wallet_type': 'currency')
    # @users = @users.where('wallets.currency': params[:currency]) if params[:currency].present?
    # if address_params?
    #   @users = @users.joins(:address)
    #   @users = @users.where('addresses.country': params[:country]) if params[:country].present?
    #   @users = @users.where("addresses.city ILIKE ?", "%#{params[:city].strip}%") if params[:city].present?
    # end
    @users = @users.paginate(page: params[:page], per_page: Constants::PER_PAGE) || []
    # return render :index if params[:page].present?
    respond_to do |format|
      format.js
    end
  end

  def update_sport_visibility
    @user.disabled_sports = [] if @user.disabled_sports.nil?
    (params[:enabled] == "false") ? @user.disabled_sports << params[:sport_id].to_i : @user.disabled_sports.delete(params[:sport_id].to_i)
    if @user.save!
      return render json: { message: "Sport status changed." }
    else
      return render json: { error: "Something went wrong." }
    end
  end
  
  def update_settings
    @user.assign_attributes(user_settings_params)
    @user.limit_selector = params[:limit_selector]
    @user.bet_limit_updated_at = Time.zone.now if params[:limit_selector].eql?('bet')
    @user.deposit_limit_updated_at = Time.zone.now if params[:limit_selector].eql?('deposit')
    if @user.save
      render js: "toastr.success('#{t('success_update', name: 'Settings')}')"
    else
      render js: "toastr.error('#{@user.errors.full_messages.join("<br/>")}')"
    end
  end

  def get_player_kpis
    @stats = PlayerKpiStats.new(user: @user).stats
  end

  private

  def address_params?
    params[:country].present? || params[:city].present?
  end

  def generate_random_password
    "&#{SecureRandom.hex(4).capitalize}"
  end

  def user_params
    params.require(:user).permit(
      :enabled, :first_name, :last_name, :username, :status, :kyc_status,
      :password, :password_confirmation, :admin_user_id, :exclusion_time, :is_betting_allowed,
      :kyc_status_notes, :phone, :email, :date_of_birth, :bank_name, :account_number, :account_holder_name,
      address_attributes: [:state, :city, :street_address],
      admin_user_attributes: [:admin_user_id]
    )
  end

  def user_settings_params
    params.require(:user).permit(:max_one_bet_amount,
      :max_daily_bet_amount, :max_weekly_bet_amount, :max_monthly_bet_amount,
      :max_single_amount, :max_day_deposit_amount, :max_weekly_deposit_amount, :max_monthly_deposit_amount,
      :balance_amount_limit, :max_single_casino_stake, :max_daily_casino_stake, :max_weekly_casino_stake,
      :max_monthly_casino_stake)
  end

  def set_user
    if current_admin_user.is_super_admin?
      @user = User.find_by(id: params[:id])
      return if @user.present?
      flash[:error] = I18n.t('user.not_found')
    else
      flash[:error] = 'You are not authorized to perform such action.'
    end
    redirect_to admin_users_url
  end

  def set_users
    # if params[:reseller_user_id].present?
    #   @reseller = AdminUser.find_by(id: params[:reseller_user_id])
    #   @users = @reseller.users
    # elsif current_admin_user.has_role? :reseller
    #   @users = current_admin_user.users
    # elsif params[:admin_user_id].present?
    #   @reseller = AdminUser.find_by(id: params[:admin_user_id])
    #   @users = @reseller.users
    
    if current_admin_user.is_sub_admin?
      @users = current_admin_user.users
    elsif current_admin_user.is_super_admin? && params[:admin_user_id].present?
      @users = User.where(admin_user_id: params[:admin_user_id])
    else
      @users = User.all
    end
  end

  def set_wallet
    @wallet = @user.current_wallet
  end

  def user_phone
    "#{params[:country_code]}#{params[:phone_number]}"
  end

  def update_phone_number
    (@user.phone = user_phone) if user_phone.present?
  end

  def set_sports
    @sports = Sport.visible
  end

  def update_status
    response = client.post('setUserKycStatus', status_params)
    return false if response.try(:code) != '200'
    data = JSON.parse(response.body)
    data['success']
  end

  def client
    @client ||= Metamask::Client.new
  end

  def status_params
    {
    "userDepositContractAddress": @user.deposit_address,
    "kycStatus": @user.kyc_approved?
    }
  end

  def success_response
    flash[:notice] = t('success_update', name: t('user'))
    redirect_to admin_user_path(@user)
  end

  def error_response
    flash[:error] = 'Failed to update kyc status'
    redirect_to admin_user_path(@user)
  end
end
