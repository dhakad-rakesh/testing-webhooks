class User::CreditReferralAmountIntr < ApplicationInteraction
  object :user

  def execute
    return unless eligible_transfer?
    User.transaction do
      create_transfer_record!
      create_ledger_transaction!
      credit_referrer_wallet!
      update_referrer_relation!
    end
    Notifications::PublishNotificationJob.perform_later(@ledger.id, Constants::NOTIFICATION_KIND[:referral_reward])
  end

  # TODO: Mark transfers which cannot be credited as referrer closed the account
  def eligible_transfer?
    user.eligible_to_credit_referrer? && user.referrer.present?
  end

  def create_transfer_record!
    @transfer_record = TransferRecord.create!(transfer_record_params)
  end

  def create_ledger_transaction!
    @ledger = referrer.current_wallet.ledgers.create!(
      amount: reward_amount, 
      remark: remark,
      approved: true,
      transaction_type: 'credit',
      kind: Ledger::REFERRAL_REWARD,
      betable_type: "TransferRecord",
      betable_id: @transfer_record.id,
      transfer_record_id: @transfer_record.id, # Not interrupting current implementation
      status: Ledger::SUCCEEDED
    )
  end

  def credit_referrer_wallet!
    referrer.current_wallet.credit(reward_amount, withdrawable: false, cashback_type: 'betting')
  end

  def update_referrer_relation!
    user.referrer_relation.update!(status: Referral::CREDITED)
  end

  def referrer
    @referrer ||= user.referrer
  end

  def transfer_record_params
    {
      payor_id: user.id,
      payee_id: user.referrer.id,
      amount: reward_amount,
      actual_transfer: reward_amount,
      commision_earned: 0,
      kind: TransferRecord::REFERRAL_REWARD
    }
  end

  def reward_amount
    @amount ||= user.referrer_relation.reward_amount
  end

  def remark
    "Referral reward"
  end
end

