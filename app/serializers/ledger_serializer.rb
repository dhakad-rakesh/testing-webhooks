class LedgerSerializer < BaseSerializer
  attributes :transaction_type, :remark, :amount, :mode, :status,
    :created_at, :category, :kind, :tracking_id, :id
  attribute :cashback_details, if: 'object.cashback?'
  attribute :referred_user_details, if: 'object.referral_reward?'

  def category
    case object.betable_type.downcase
    when 'user', 'adminuser'
      'User'
    when 'bet', 'combobet'
      'Bet'
    when 'transferrecord'
      'Referral reward'
    end
  end

  # TODO: Refactor structure similar to cashback and use referral relation instead of transfer record
  def referred_user_details
    {
      id: object.betable_id,
      name: object.betable.payor.full_name,
    }
  end

  def cashback_details
    object.user_promo_code.details
  end

  def mode
    object.mode&.humanize
  end
end
