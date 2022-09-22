class ComboBetSerializer < BaseSerializer
  attributes :id, :user_id, :status, :stake, :odds, :cashoutable, :is_cashoutable, :cashout_amount, :date, :to_return, :type, :cashed_out_amount, :betting_bonus

  has_many :bets

  def is_cashoutable
    object.cashoutable?
  end

  def cashoutable
    object.cashoutable
  end

  def date
    object.created_at
  end

  def status
    I18n.t("bets.status.#{object.custom_status}")
  end

  def type
    object.class.name
  end

  def cashed_out_amount
    object&.cashout_amount
  end
end