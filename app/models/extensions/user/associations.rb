module Extensions
  module User
    module Associations
      extend ActiveSupport::Concern

      included do
        has_many :access_grants, class_name: 'Doorkeeper::AccessGrant', foreign_key: :resource_owner_id, dependent: :delete_all # rubocop:disable Rails/InverseOf, Metrics/LineLength
        has_many :access_tokens, class_name: 'Doorkeeper::AccessToken', foreign_key: :resource_owner_id, dependent: :delete_all # rubocop:disable Rails/InverseOf, Metrics/LineLength
        has_many :bets, dependent: :restrict_with_error
        has_many :accumulator_bets, dependent: :restrict_with_error
        has_many :session_logs, dependent: :destroy
        has_many :combo_bets
        has_many :user_promo_codes
        has_many :promo_codes, through: :user_promo_codes
        has_many :q_tech_free_rounds

        has_one_attached :image

        # User will have multiple wallets and only one wallet will be current_wallet.
        # All amount always will be deducted from current_wallet.
        has_many :wallets, as: :usable, dependent: :delete_all
        has_many :security_answers, dependent: :destroy
        has_many :security_questions, through: :security_answers, dependent: :destroy
        has_many :ledgers, through: :wallets
        has_many :participants, dependent: :destroy
        has_many :betting_pools, through: :participants
        belongs_to :admin_user, optional: true
        %I[languages topics occupations organizations groups].each do |association|
          has_and_belongs_to_many association
        end
        before_destroy do
          [groups, organizations, languages, topics, occupations].map(&:clear)
        end

        has_many :game_sessions, foreign_key: :player_id
        has_many :session_transactions, foreign_key: :player_id

        has_many :transfer_records, foreign_key: :payor_id
        has_many :payees, through: :transfer_records

        has_one :address, autosave: true, dependent: :destroy

        has_one :referrer_relation, class_name: "Referral", dependent: :destroy
        has_one :referrer, through: :referrer_relation
        has_many :referral_relations, class_name: "Referral", foreign_key: "referrer_id"
        has_many :referrals, through: :referral_relations, source: :user
      end
    end
  end
end
