class NotificationType < ApplicationRecord
  ENABLED = 'enabled'
  DISABLED = 'disabled'
  BET = 'bet'
  COMBO_BET = 'combo_bet'
  WITHDRAWAL_SETTLEMENT = 'withdrawal_settlement'
  REFERRAL_REWARD = 'referral_reward'
  PROMO_CODE = 'promo_code'
  FAVOURITE_MATCH = 'favourite_match'
  DEPOSIT_REQUEST = 'deposit_request'
  WITHDRAWAL_REQUEST = 'withdrawal_request'
  BIG_WIN = 'big_win'
  LIABILITY_EXCEEDED = 'liability_exceeded'

  STATUSES = {
    ENABLED => 0,
    DISABLED => 1
  }

  KINDS = {
    BET => 0, 
    COMBO_BET => 1,
    WITHDRAWAL_SETTLEMENT => 2,
    REFERRAL_REWARD => 3,
    PROMO_CODE => 4,
    FAVOURITE_MATCH => 5,
    DEPOSIT_REQUEST => 6,
    WITHDRAWAL_REQUEST => 7,
    BIG_WIN => 8,
    LIABILITY_EXCEEDED => 9
  }

  enum status: STATUSES
  enum kind: KINDS
end
