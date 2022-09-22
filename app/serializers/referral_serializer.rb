class ReferralSerializer < BaseSerializer
  attributes :id, :status, :reward_amount, :threshold_amount
  belongs_to :user
end
