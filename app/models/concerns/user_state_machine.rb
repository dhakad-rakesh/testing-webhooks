module UserStateMachine
  extend ActiveSupport::Concern

  STATES = {
    profile_completion_pending: PROFILE_COMPLETION_PENDING = 'profile_completion_pending',
    contact_updation_pending: CONTACT_UPDATION_PENDING =  'contact_updation_pending',
    phone_verification_pending: PHONE_VERIFICATION_PENDING = 'phone_verification_pending',
    completed_sign_up: COMPLETED_SIGN_UP = 'completed_sign_up'
  }.freeze

  DEFAULT_STATUS = PROFILE_COMPLETION_PENDING
  SIGN_UP_PENDING_STATUS = [PROFILE_COMPLETION_PENDING, CONTACT_UPDATION_PENDING, PHONE_VERIFICATION_PENDING].freeze

  included do
    enum states: STATES

    include AASM

    aasm column: :state, enum: true do
      state :profile_completion_pending
      state :contact_updation_pending
      state :phone_verification_pending, initial: true
      state :completed_sign_up

      event :complete_profile do
        transitions from: %i(profile_completion_pending contact_updation_pending phone_verification_pending),
                    to: :contact_updation_pending
      end

      event :update_contact_details do
        transitions from: %i(contact_updation_pending phone_verification_pending 
                              completed_sign_up),
                    to: :phone_verification_pending
      end

      event :complete_phone_verification do
        transitions from: :phone_verification_pending,
                    to: :completed_sign_up
      end

      event :complete_sign_up do
        transitions from: %i(phone_verification_pending completed_sign_up),
                    to: :completed_sign_up
      end
    end

    validates :state, presence: true

  end
end
  