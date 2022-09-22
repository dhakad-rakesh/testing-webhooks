module Casino
  class CreateGameSessionTransaction
    include BetAndHold
    include Utility::Casino::Response
    include Utility::UserLimitsHelper
    attr_accessor :params, :user

    def initialize(params, user)
      @params = params
      @user = user
    end

    def call
      gs = GameSession.find_by(session_id: params[:session_id])

      return internal_error_response if gs.nil?

      existing_st = exist_session_trnsaction(gs, params)
      return funds_response(existing_st) if existing_st.present?

      e_arst = exist_alredy_refund_session_trnsaction(gs, params)
      return funds_response(e_arst) if e_arst.present?

      # return check_if_alreay_refunded(params[:transaction_id], gs) if params[:type] == 'refund'
      e_rst = exist_refund_session_trnsaction(gs, params) if params[:type] == 'refund'
      s_trnsaction = gs.session_transactions.new(session_transaction_params)

      update_wallet_amount(params, s_trnsaction, e_rst, gs.game_uuid)

      if s_trnsaction.is_success?
        response = funds_response(s_trnsaction)
        response = funds_response(e_rst) if e_rst&.bet_type == 'win'
        # response.merge!(rollback_transactions: fetch_transactions_to_rollback(gs)) if params[:type] == 'refund'
        response
      else
        insufficient_funds_response
      end
    end

    private

    def session_transaction_params
      params.permit(:amount, :currency, :game_uuid, :player_id,
                    :transaction_id, :session_id, :bet_type,
                    :bet_transaction_id, :free_spin_id, :quantity)
    end

    def utilized_casino_bonus(amount)
      amount.to_f <= available_casino_bonus ? stake : available_casino_bonus
    end

    def available_casino_bonus
      bet_wallet.wallet.casino_bonus
    end

    def update_wallet_amount(params, s_trnsaction, e_rst, game_uuid)
      ActiveRecord::Base.transaction do
        # This is for valid refund request
        if invalid_request?(e_rst, params)
          result = true
        else
          result = if Constants::PROFIT_BET_TPES.include?(params[:type])
            credit_bet_wallet(params[:amount], s_trnsaction)
          else
            validate_casino_limits!(params[:amount])
            s_trnsaction.utilized_bonus = utilized_casino_bonus(params[:amount])
            debit_bet_wallet(params[:amount], s_trnsaction)
          end
        end
        s_trnsaction.status = 'failed' unless result
        s_trnsaction.wallet_balance = user.available_amount
        s_trnsaction.game_uuid = game_uuid if s_trnsaction.game_uuid.blank?
        s_trnsaction.save!
      end
    rescue ::Casino::BetLimit => e
      notification = { user: user, notification: { title: 'Limit Exceeded', body: e.message } }
      Firebase::PublishNotification.run!(notification)
    rescue Exception => e
      NotificationMailer.casino_error_logs_job(params.to_json, s_trnsaction.to_json, e_rst.to_json, e.message).deliver_later  
    end

    def validate_casino_limits!(amount)
      validate_casino_limit(user: user, stake: amount)
    end

    def credit_bet_wallet(amount, s_trnsaction)
      return true if amount.to_f <= 0

      if s_trnsaction.bet_type == 'refund'
        create_ledger(amount, s_trnsaction)
        return true
      end
      
      amount = bet_wallet.credit(amount.to_f)
      create_ledger(amount, s_trnsaction) unless amount.zero?
      true
    end

    def debit_bet_wallet(amount, s_trnsaction)
      return true if amount.to_f <= 0

      begin
        if bet_wallet.debit(amount.to_f, bonus_type: 'casino').save
          create_ledger((-amount.to_f), s_trnsaction)
          return true
        end
      rescue Exception => e
      end
    end

    # Important: Bet with provided transaction_id should be processed only once.
    # If you already processed this transaction, then return successful response with processed transaction ID on the integrator side
    def check_if_alreay_refunded(transaction_id, gs)
      st = gs.session_transactions
             .refund_types
             .find_by(transaction_id: transaction_id)
      { transaction_id: transaction_id, balance: st.wallet_balance } if st
    end

    def fetch_transactions_to_rollback(gs)
      gs.session_transactions
        .bet_types
        .win_types
        .pluck(:transaction_id)
    end

    def bet_wallet
      @bet_wallet ||= Wallets::Base.new(current_wallet)
    end

    def exist_session_trnsaction(gs, params)
      gs.session_transactions.find_by(transaction_id: params[:transaction_id], bet_type: params[:type])
    end

    def exist_refund_session_trnsaction(gs, params)
      gs.session_transactions
        .find_by(transaction_id: params[:bet_transaction_id])
    end

    def exist_alredy_refund_session_trnsaction(gs, params)
      return false if params[:bet_transaction_id].blank?

      gs.session_transactions
        .find_by(bet_transaction_id: params[:bet_transaction_id])
    end

    def invalid_request?(e_rst, params)
      # All these are failed condition not to return balance
      # 1. Valid request should have type of `bet`, win is wrong reqeust type.
      # 2. bet type should not be nil, here I am assiging bet type toggle valud in nil_type.
      # 3. If any bet failed due to low balance than received refund request, amount shuldn't be credit to user account in this case.
      (e_rst&.bet_type == 'win' || (e_rst&.bet_type != 'bet' && params[:nil_type].present?)) || e_rst&.is_failed?
    end

    def create_ledger(amount, s_trnsaction)
      remark = "#{s_trnsaction.bet_type.capitalize} of #{s_trnsaction.amount} for playing Casino game"
      if s_trnsaction.bet_type == 'refund'
        t_type = :refund
        approved = 0
      else
        t_type = Constants::PROFIT_BET_TPES.include?(s_trnsaction.bet_type) ? :credit : :debit
      end
      Ledgers::GenerateBetLedgers.new(wallet: bet_wallet.wallet, transaction_type: t_type, amount: amount, approved: approved,
                                      remark: remark, betable: user, transaction_id: s_trnsaction.transaction_id).call
    end
  end
end
