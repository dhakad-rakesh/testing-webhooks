class Api::SettingsController < Api::BaseController
  skip_before_action :user_authorize!
  before_action :set_language
  def index
    app_constants = {
      limits: {
        timeout_limit: {
          periods: Constants::TIME_OUT_LIMIT
        },
        maximum_reality_limit: {
          value: Constants::MAXIMUM_REALITY_LIMIT,
          interval: Constants::REALITY_LIMIT_INTERVAL
        },
        betting: {
          max_one_bet_amount: GammabetSetting.max_one_bet_amount,
          max_daily_bet_amount: GammabetSetting.max_daily_bet_amount,
          max_weekly_bet_amount: GammabetSetting.max_weekly_bet_amount,
          max_monthly_bet_amount: GammabetSetting.max_monthly_bet_amount,
          max_liability_amount: GammabetSetting.max_liability_amount
        },
        deposits: {
          max_single_amount: GammabetSetting.max_single_amount,
          max_day_deposit_amount: GammabetSetting.max_day_deposit_amount,
          max_weekly_deposit_amount: GammabetSetting.max_weekly_deposit_amount,
          max_monthly_deposit_amount: GammabetSetting.max_monthly_deposit_amount,
          minimum_deposit_amount: GammabetSetting.minimum_deposit_amount
        },
        balance: {
          balance_amount_limit: GammabetSetting.balance_amount_limit
        },
        withdrawals: {
          auto_withdrawal_limit: GammabetSetting.auto_withdrawal_limit,
          minimum_withdrawal_amount: GammabetSetting.minimum_withdrawal_amount,
          maximum_withdrawal_amount: GammabetSetting.maximum_withdrawal_amount
        }
      },
      support: {
        emails: Constants::SUPPORT_EMAILS,
        message: Constants::SUPPORT_MESSAGE,
        bank_list: Constants::BANK_LIST
      },
      odds_update_interval: Figaro.env.ODDS_CHANGE_INTERVAL,
      fund_transfer_allowed: GammabetSetting.first.fund_transfer_allowed,
      fund_transfer_commision: GammabetSetting.first.fund_transfer_commision,
      user_wallet_limit: GammabetSetting.user_wallet_limit,
      prematch_top_markets: Constants.prematch_top_markets,
      inplay_top_markets: Constants.inplay_top_markets,
      notification_kinds: Constants::NOTIFICATION_KIND,
      cashout: {
        commision: GammabetSetting.cashout_commision,
        status: GammabetSetting.cashout_allowed?
      },
      bonus_setting: {
        betting_bonus_allowed: GammabetSetting.betting_bonus_allowed?,
      },
      languages: available_languages
    }
    render_success_response(app_constants)
  end

  def languages
    render json: available_languages
  end
  
  private
  
  def available_languages
    enabled_sym = Language.enabled.pluck :symbol
    language_options = Constants::LANGUAGE_OPTIONS[@language.symbol.to_sym]
    language_options.map { |symbol, language| { value: language, id: symbol } if enabled_sym.include? symbol.to_s  }.compact if language_options
  end

  def set_language
    language = Language.find_by(symbol: request.headers['Accept-Language'])
    @language = language&.enabled ? language : Language.find_by(symbol: Constants::DEFAULT_LANGUAGE)
  end

  # def find_policy_url
  #   data = []
  #   Verbiage.except_how_to_play.order(:created_at).each do |verbiage|
  #     content = {}
  #     content[:title] = verbiage.verbiage_type.tr('-', ' ').titleize

  #     content[:url] =
  #       base_url_verbiage + "/policy/#{verbiage.verbiage_type}"
  #     data << content
  #   end
  #   data
  # end

  # def base_url_verbiage
  #   if Rails.env.staging?
  #     Constants::STAGING_DOMAIN
  #   elsif Rails.env.production?
  #     Constants::PRODUCTION_DOMAIN
  #   else
  #     'http://localhost'
  #   end
  # end
end
