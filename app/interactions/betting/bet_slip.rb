module Betting
  class BetSlip < Betting::Base
    include Utility::UserLimitsHelper

    object :user
    object :wallet
    integer :match_id
    integer :market_id
    integer :market_uid
    string :outcome_id
    string :odds
    string :team_name, default: nil
    string :player_name, default: nil
    string :period, default: nil
    string :play_number, default: nil
    symbol :bet_type, default: :traditional
    symbol :play_type, default: nil
    float :stake, default: nil
    float :total
    string :identifier, default: ''
    string :specifier_name, default: ''
    string :specifier, default: nil
    integer :combo_bet_id, default: nil
    hash :specifier_text, strip: false#, default: {}
    string :outcome_name

    attr_accessor :match

    set_callback :type_check, :before, :set_bet_type
    set_callback :type_check, :before, :set_play_type
    set_callback :type_check, :before, :format_market_uid
    set_callback :type_check, :before, :validate_match_scheduled_date
    # set_callback :type_check, :before, :validate_match_time
    set_callback :type_check, :before, :validate_systems_betting_status
    set_callback :type_check, :before, :validate_is_market_suspended?
    set_callback :type_check, :before, :validate_schedule_time_for_prematch
    set_callback :type_check, :before, :set_data
    set_callback :type_check, :before, :validate_data
    set_callback :type_check, :before, :validate_odds
    set_callback :type_check, :before, :validate_stake
    set_callback :type_check, :before, :set_total
    set_callback :type_check, :before, :validate_status
    set_callback :type_check, :before, :set_specifier
    set_callback :type_check, :before, :validate_specifier
    set_callback :type_check, :after, :validate_betting_status
    # set_callback :type_check, :before, :validate_min_play_value
    # set_callback :type_check, :before, :validate_max_play_value
    set_callback :type_check, :after, :validate_user_enabled_sport
    set_callback :type_check, :after, :validate_global_enabled_sport
    set_callback :type_check, :before, :validate_bet_limit
    set_callback :type_check, :before, :validate_liability
    set_callback :type_check, :before, :validate_match_status

    def execute
      bet = Bet.new(inputs_with_market_and_outcome_object)
      errors.add(:bet, bet.errors.full_messages.to_sentence) unless bet.save
      bet
    end

    def validate_match_scheduled_date
      errors.add(:match, I18n.t(:not_valid)) if match.inactive_states? && match.invalid_scheduled_date?
    end

    def validate_match_time
      return true unless match.is_live?
      errors.add(:match, I18n.t(:betting_timeout)) if match.running_time.split(":").first.to_i >= 87
    end

    def set_data
      if match.in_play?
        data = match.firestore_snapshot
        errors.add(:match, I18n.t(:no_data)) unless ( data.present? && data[:market].present? )
      else 
        data = match&.odds_data
        if (Market.player_market_ids.include?(market_id) && data.dig(:player_markets).nil?) ||
           data&.dig(:markets).nil?
          errors.add(:match, I18n.t(:no_data))
        end
      end
    end

    def set_total
      self.total = NumberService.round_to_8_decimal(stake.to_f * odds.to_f)
    end

    def set_bet_type
      errors.add(:match, I18n.t(:not_found_msg)) if match.blank?
      self.bet_type = bet_type || :traditional
    end

    def set_play_type
      self.play_type = match.in_play? ? :inplay : :pregame
    end

    def validate_systems_betting_status
      errors.add(:match, I18n.t(:betting_disabled)) if match.is_live? && !GammabetSetting.live_betting_allowed?
    end

    def validate_data
      errors.add(:market, I18n.t(:not_found_msg)) if identifier_data.nil? || outcome_data.nil? || identifier_data.blank? || outcome_data.blank?
    end

    def identifier_data
      if match.in_play?
        data = match.firestore_snapshot unless @identifier_data.present?
        @identifier_data ||= data.dig(:market, @formated_market_uid.to_s.to_sym ) if data.present?
        @identifier_data || {}
      else
        Utility::MarketUtility.identifier_data(match.id, market_id.to_s, "49")
      end
    end

    def validate_specifier
      if specifier_text[:handicap].blank? || specifier_text[:handicap] == outcome_data[:handicap]
         #(@market_data.dig(:specifier) || {}).with_indifferent_access == specifier_text.with_indifferent_access
        true
      else
        errors.add(:specifier, I18n.t(:not_valid))
      end
    end

    def outcome_data
      return {} if identifier_data.blank?
      identifier_data.dig(:outcomes, outcome_id.to_s) || identifier_data.dig(:outcomes, outcome_id.to_i) || identifier_data.dig(:outcomes, outcome_id.to_s.to_sym) || {}
    end

    # def validate_betting_status
    #   return true if match && Constants::MATCH_BETTING_ALLOWED_STATUS.include?(match.betting_status)
    #   errors.add(:match, 'has ended or not available for betting currently.')
    # end

    def validate_betting_status
      return true if outcome_data.blank? || ( outcome_data[:status] == "open" || Bet.ls_status(outcome_data[:Status]) == "open" )
      errors.add(:bet, I18n.t(:odds_suspended, status: ( outcome_data[:status] || Bet.ls_status(outcome_data[:Status])) ))
    end

    def validate_odds
      odd_key = match.in_play? ? :Price : :odds
      return true if (outcome_data || {}).dig(odd_key).to_f == odds.to_f
      errors.add(:base, I18n.t(:invalid_odds))
    end

    def set_specifier
      self.specifier_text = identifier.present? ? (eval identifier) : {}
    end

    def validate_stake
      return true if combo_bet_id.present? || stake.to_f.positive?
      errors.add(:bet, I18n.t(:stake_not_positive))
    end

    def validate_status
      if match.in_play?
        return true if Bet.ls_status(outcome_data[:Status]) == 'open'
        errors.add(:bet, I18n.t(:invalid, status: Bet.ls_status(outcome_data[:Status])))
      else
        return false if identifier_data.blank?
        status = identifier_data[:status]
        return true if status.include?('open')
        errors.add(:bet, I18n.t(:invalid, status: identifier_data[:status]))
      end
    end

    def validate_min_play_value
      message = "You've to stake amount greater than minimum limit."
      @combo = ComboBet.find_by(id: combo_bet_id)
      stake_amt = @combo.present? ? @combo.stake : stake
      errors.add(:stake, I18n.t(:invalid_min_stake)) if stake_amt.to_f < Constants::MIN_PLAY.to_f
    end

    def validate_max_play_value
      message = "You’ve exceeded your maximum limit."
      stake_amt = @combo.present? ? @combo.stake : stake
      errors.add(:stake, I18n.t(:invalid_max_stake)) if stake_amt.to_f > Constants::MAX_PLAY.to_f
    end

    def validate_bet_limit
      @combo = ComboBet.find_by(id: combo_bet_id)
      common_stake = @combo.present? ? @combo.stake : stake
      valid_bet_limits(user: user, stake: common_stake)
    end

    # def valid_max_daily_bet_limit
    # end

    # def valid_max_weekly_bet_limit
    # end

    # def valid_max_monthly_bet_limit
    # end

    def format_market_uid
      @formated_market_uid = market_uid.to_s
      if specifier.present?
        @formated_market_uid += "^#{specifier.to_s}" 
        self.specifier_name = specifier.to_s
      end
    end

    def validate_liability
      possible_win = @combo.present? ? @combo.possible_win : stake * odds.to_f
      return if (match.liability + possible_win) < GammabetSetting.max_liability_amount.to_f
      errors.add(:base, I18n.t(:betting_stopped))
    end

    def validate_is_market_suspended?
      unless Market.markets_enable_ids.include?(market_uid.to_s)
        errors.add(:market, I18n.t(:disabled))
      end
    end

    def inputs_with_market_and_outcome_object
      values = inputs.except(:market_uid, :specifier)
      market = Market.find_by_uid inputs[:market_uid]
      if market
        values[:market_id] = market.id
        values[:market_uid] = market.uid
        values[:market_category_name] = market.categories&.first&.name || 'others'
      end
      values
    end

    def validate_user_enabled_sport
      return unless user.disabled_sports&.include?(match.sport_id)
      errors.add(:base, I18n.t('errors.messages.sports.not_available'))
    end

    def validate_global_enabled_sport
      return unless Sport.disabled_sports.pluck(:id).include?(match.sport_id)
      errors.add(:base, I18n.t('errors.messages.sports.not_available'))
    end

    def match
      @match ||= Match.find_by(id: match_id)
    end

    def validate_match_status
      return if match.playable?
      errors.add(:base, I18n.t(:betting_disabled))
    end

    def validate_schedule_time_for_prematch
      errors.add(:base, I18n.t('errors.messages.matches.scheduled_time_passed')) if !match.in_play? && match.is_scheduled_time_passed?
    end
  end
end