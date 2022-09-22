class RecalculateBetBonusJob < ApplicationJob
  queue_as :low
  def perform
    if GammabetSetting.betting_bonus_allowed?
      ComboBet.where(status: "pending").find_in_batches do |group|
        group.each do |combo_bet|
          combo_bet.update_betting_bonus!
        end
      end
    else
      ComboBet.where(status: "pending").update_all(betting_bonus: 0.0)
    end
  end
end
