class Admin::WalletsController < Admin::BaseController
  include Utility::PublishWallet
  before_action :set_wallet, only: %I[edit update update_currency]
  before_action :validate_user_wallet_amount, only: :update


  def edit; end

  def update
    amount = is_debit ? - params[:amount].to_f : params[:amount].to_f

    if !params[:amount].to_f.positive?
      flash[:error] = t('wallets.errors.invalid_amount')
    elsif is_debit && @wallet.withdrawable_amount < amount.abs
      flash[:error] = t('wallets.errors.debit_limit', amount: @wallet.withdrawable_amount)
    end

    if flash[:error].present?
      redirect_to params[:admin_user_id].present? ? edit_admin_admin_user_wallet_path(@user.current_wallet, admin_user_id: @user.id)
        : edit_admin_user_wallet_path(@user, @user.current_wallet) and return 
    end

    if current_admin_user.is_reseller?
      @self_wallet = current_admin_user.reseller_wallet
      @admin_wallet = current_admin_user.current_wallet
      available_amount = @admin_wallet.available_amount
      available_amount = available_amount + @self_wallet.available_amount if @wallet.usable_type == "User"
      if !is_debit && available_amount < amount
        flash[:error] = t('wallets.errors.insufficient_amount')
        redirect_to params[:admin_user_id].present? ? edit_admin_admin_user_wallet_path(@user.current_wallet, admin_user_id: @user.id)
          : edit_admin_user_wallet_path(@user, @user.current_wallet) and return
      end
    end

    if @wallet.update_attributes(available_amount: @wallet.available_amount + amount, withdrawable_amount: @wallet.withdrawable_amount + amount)
      if is_credit && amount >= Constants::DEPOSITED_AMOUNT
        NotificationMailer.deposited_amount_alert(@user, amount).deliver_later
      end
      # Publish wallet to firebase
      publish_wallet(@wallet.reload)
      current_admin_user.is_reseller? ? update_reseller_wallets(amount) : create_ledger(amount)
      flash[:notice] = t('success_update', name: t('amount'))
    else
      flash[:error] = t('went_wrong')
    end
    redirect_to params[:admin_user_id].present? ? admin_admin_user_path(@user) : admin_user_path(@user)
  end

  def update_currency
    if @wallet.update(currency: params.dig(:wallet, :currency))
      flash[:notice] = t('success_update', name: t('currency'))
    else
      flash[:error] = @wallet.errors.full_messages.join(',')
    end
    redirect_to admin_user_path(@user)
  end

  private

  def set_wallet
    @user = if params[:admin_user_id].present?
              AdminUser.find_by(id: params[:admin_user_id])
            else
              User.find_by(id: params[:user_id])
            end
    @wallet = @user&.wallets&.find_by(id: params[:id])
    return if @user.present? && @wallet.present?
    flash[:error] = t('not_found', name: t('user')) if @user.blank?
    flash[:error] = t('not_found', name: 'wallet') if @wallet.blank?
    redirect_to admin_users_url
  end

  def is_debit
    params[:commit] == 'debit'
  end

  def is_credit
    params[:commit] == 'credit'
  end

  def update_reseller_wallets(amount)
    if is_debit
      wallet = @user.is_a?(User) ? @self_wallet : @admin_wallet
      wallet.credit(amount.abs)
      create_ledger(amount, @self_wallet.id)
      update_wallet_cache(amount)
    else
      if @wallet.usable_type == "User" && @self_wallet.available_amount >= amount
        @self_wallet.debit(amount)
        create_ledger(amount, @self_wallet.id)
      else
        if @wallet.usable_type == "User" #reseller to reseller, only with admin wallet.
          available_amount = @self_wallet.available_amount
          remaining_amount = amount - available_amount
          if available_amount.positive?
            @self_wallet.debit(available_amount)
            create_ledger(available_amount, @self_wallet.id)
          end
        else # reseller to reseller
          remaining_amount = amount
        end

        @admin_wallet.debit(remaining_amount)
        create_ledger(remaining_amount, @admin_wallet.id)
      end
    end
  end

  def create_ledger(amount, source_wallet_id = nil)
    if @user.is_a?(AdminUser)
      user_type = 'reseller'
      email = @user.email
    else
      user_type = 'user'
      email = @user.username
    end
    remark =  if current_admin_user.is_reseller?
                t('wallets.update.by_reseller', reseller: current_admin_user.email, 
                 user: user_type, user_email: email)
              else
                t('wallets.update.by_admin', user: user_type, user_email: email)
              end
    Ledgers::GenerateBetLedgers.new(wallet: @wallet, transaction_type: params[:commit].to_sym, amount: amount,
                                    source_wallet_id: source_wallet_id, remark: remark, betable: @user, mode: 'admin',
                                    admin_user_id: current_admin_user.id).call
  end

  def validate_user_wallet_amount
    #reseller debit from user wallet limited to 3K
    if current_admin_user.is_reseller? && @user.is_a?(User) && is_debit
      user_todays_debit = Rails.cache.fetch(Utility::Cache.user_todays_debit_key(@user.id))
      if user_todays_debit.to_i + params[:amount].to_f > GammabetSetting.reseller_withdrawal_limit
        flash[:error] = t('wallets.errors.debit_limit', amount: "#{GammabetSetting.reseller_withdrawal_limit} per day")
        redirect_to params[:admin_user_id].present? ? edit_admin_admin_user_wallet_path(@user.current_wallet, admin_user_id: @user.id)
          : edit_admin_user_wallet_path(@user, @user.current_wallet) and return
      end
    end
  end

  def update_wallet_cache(amount)
    return unless @user.is_a?(User)
    user_todays_debit_key = Utility::Cache.user_todays_debit_key(@user.id)
    debited_amount = Rails.cache.fetch(user_todays_debit_key)
    if debited_amount.nil?
      Rails.cache.write(
        user_todays_debit_key, 
        @user.ledgers.between(Time.zone.now.beginning_of_day, Time.zone.now).debit.where(
        source_wallet_id: current_admin_user.wallets.pluck(:id)).sum(:amount).abs
      )
    else
      debited_amount += amount.abs
      Rails.cache.write(user_todays_debit_key, debited_amount)
    end
  end
end
