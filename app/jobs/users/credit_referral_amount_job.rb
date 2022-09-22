class Users::CreditReferralAmountJob < ApplicationJob
  queue_as :low

  def perform(referral_id)
    referral = User.find_by(id: referral_id)
    return unless referral
    User::CreditReferralAmountIntr.run!(user: referral) 
  end
end
