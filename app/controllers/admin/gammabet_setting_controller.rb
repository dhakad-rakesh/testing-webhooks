class Admin::GammabetSettingController < Admin::BaseController
  before_action :set_setting, only: %i[update edit update_referral_settings update_commision_settings]
  before_action :set_languages, only: %i[edit]

  def edit; end

  def update
    @setting.assign_attributes(setting_params)
    if @setting.save
      RecalculateBetBonusJob.perform_later if setting_params.include?("betting_bonus_allowed") # We need to update bonus on pending combo bet
      render js: "toastr.success('Settings updated successfully')"
    else
      render js: "toastr.error('#{@setting.errors.full_messages.join('\n')}')"
    end
  end

  def navbar_type
    session[:navbar_type] = (params[:navbar_type] == 'true')
  end

  def update_referral_settings
    @setting.assign_attributes(referral_params)

    if @setting.save
      render js: "toastr.success('Settings updated successfully')"
    else
      render js: "toastr.error('#{@setting.errors.full_messages.join('\n')}')"
    end
  end

  def update_notification_settings
    NotificationType.send(params[:kind]).last.send("#{params[:status]}!")
  end

  def update_commision_settings
    @setting.assign_attributes(commision_params)
    if @setting.save
      render js: "toastr.success('Settings updated successfully')"
    else
      render js: "toastr.error('#{@setting.errors.full_messages.join('\n')}')"
    end
  end

  private

  def set_languages
    @launguages = Language.all
  end

  def commision_params
    commision_params = { agent_commision: {}}
    %i[range_1 range_2 range_3].each do |sym|
      if params[:agent_commision][sym].present?
        commision_params[:agent_commision][sym] = {}
        %i[amount percentage].each do |attribute|
          commision_params[:agent_commision][sym][attribute] = params[:agent_commision][sym][attribute].to_i
        end
      end
    end
    commision_params
  end

  def referral_params
    referral_param = {}
    %i[referral_reward_amount referral_threshold_amount].each do |sym|
      if params[sym].present?
        referral_param[sym] = { 'IQD' => params[sym] }
      end
    end
    referral_param
  end

  def set_setting
    @setting = GammabetSetting.find_by(setting_of: :application)
  end

  def setting_params
    params.require(:gammabet_setting).permit(:allow_betting, :url, :fund_transfer_allowed,
      :fund_transfer_commision, :fund_transfer_limit, :cashout_allowed, :cashout_commision, :api_version,
      :user_wallet_limit, :reseller_withdrawal_limit, :auto_withdrawal_limit,
      :max_one_bet_amount, :max_daily_bet_amount, :max_weekly_bet_amount, :max_monthly_bet_amount,
      :max_single_amount, :max_day_deposit_amount, :max_weekly_deposit_amount, :max_monthly_deposit_amount,
      :balance_amount_limit, :minimum_deposit_amount, :minimum_withdrawal_amount, :maximum_withdrawal_amount,
      :max_liability_amount, :max_single_casino_stake, :max_daily_casino_stake, :max_weekly_casino_stake,
      :max_monthly_casino_stake, :conversion_rate, :deposit_bonus_limit, :deposit_bonus_amount, :deposit_bonus_allowed,
      :referral_threshold_amount, :referral_reward_amount, :referral_bonus_allowed,
      :betting_bonus_allowed
    )
  end
end
