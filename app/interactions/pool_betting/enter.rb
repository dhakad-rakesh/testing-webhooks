module PoolBetting
  class Enter < ApplicationInteraction
    integer :user_id, default: nil
    integer :betting_pool_id, default: nil

    validate :check_user
    validate :check_pool
    validate :check_user_balance

    def execute
      ActiveRecord::Base.transaction do
        deduct_user_balance(@betting_pool.entry_amount)
        begin
          pool_wallet = @user.wallets.create!(wallet_type: :betting_pool, available_amount: @betting_pool.points_per_user)
          @participant = Participant.create(user_id: user_id,
                                            betting_pool_id: betting_pool_id, wallet_id: pool_wallet.id)
          @betting_pool.update(total_participants: @betting_pool.total_participants + 1)
        rescue ActiveRecord::RecordNotUnique # Handle race condition
          errors.add(:betting_pool, 'already joined')
          raise ActiveRecord::Rollback
        else
          if @participant.errors.present? # Handle case when participant creation fails
            errors.merge!(@participant.errors)
            fail ActiveRecord::Rollback
          end
        end
      end
    end

    private

    def deduct_user_balance(amount)
      @wallet.debit(amount)
    end

    def check_user
      @user = User.find_by(id: user_id)
      errors.add(:user, 'not found') if @user.blank?
    end

    def check_pool
      @betting_pool = BettingPool.find_by(id: betting_pool_id)
      errors.add(:betting_pool, 'not found') if @betting_pool.blank?
    end

    def check_user_balance
      # Use main wallet of user here later
      return if @user.blank? || @betting_pool.blank?
      @wallet = @user.currency_wallet
      @betting_pool && @wallet &&
        (@wallet.available_amount < @betting_pool.entry_amount) &&
        errors.add(:wallet, 'balance not sufficient')
    end
  end
end
