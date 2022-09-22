module Notifications
  class PublishNotification < ApplicationInteraction
    object :user, default: nil
    integer :notification_object_id
    string :kind
    hash :options, default: {}, strip: false

    validate :validate_notification_type

    # TODO: DRY notification builders
    BUILDER_MAP = {
      :bet => Notifications::Builders::BetSettlement,
      :combo_bet => Notifications::Builders::BetSettlement,
      :withdrawal_settlement => Notifications::Builders::WithdrawalSettlement,
      :referral_reward => Notifications::Builders::ReferralReward,
      :promo_code => Notifications::Builders::PromoCode,
      :favourite_match => Notifications::Builders::FavouriteMatch,
      :deposit_request => Notifications::Builders::DepositRequest,
      :withdrawal_request => Notifications::Builders::WithdrawalRequest,
      :big_win => Notifications::Builders::BigWin,
      :liability_exceeded => Notifications::Builders::LiabilityExceeded
    }

    def execute
      return unless notification_type_enabled?
      notification = builder.run!(notification_params)
      Firebase::PublishNotification.run!(notification) if notification.present?
    end

    def builder
      BUILDER_MAP[kind.to_sym]
    end

    def validate_notification_type
      return if BUILDER_MAP[kind.to_sym].present?
      errors.add(:base, 'Invalid notification type')
    end

    def notification_params
      { 
        notification_object_id: notification_object_id,
        kind: kind,
        user: user,
        options: options
      }.compact
    end

    def notification_type_enabled?
      NotificationType.find_by(kind: kind)&.enabled?
    end
  end
end