module LedgersHelper
  def payout_to_admin(credits, reseller_percentage)
    credits * (reseller_percentage.to_f / 100)
  end

  def reseller_profit(credits)
    credits * ((100 - current_admin_user.reseller_percentage) / 100)
  end

  def reseller_percentage_calc(wagered_amount, user)
    commision = user.custom_commision? ? user.commision : GammabetSetting.first.agent_commision
    
    case wagered_amount
    when 0..commision.dig(:range_1, :amount)
      commision.dig(:range_1, :percentage)
    when commision.dig(:range_1, :amount)+1..commision.dig(:range_2, :amount)
      commision.dig(:range_2, :percentage)
    else
      commision.dig(:range_3, :percentage)
    end
  end
end
