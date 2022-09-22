class Onboarding::UpdateContactDetailsIntr < ApplicationInteraction
  object :user

  string :phone
  string :street_address, default: nil
  string :state, default: nil
  string :city, default: nil
  string :zip_code, default: nil

  validate :validate_user_transition

  def execute
    user.assign_attributes(user_params)
    unless user.valid?
      merge_errors(errors.messages, user.errors.messages)
      return user
    end
    User.transaction do
      @user.save!
      @user.update_contact_details!
    end
  end

  def merge_errors(errors, errors_messages)
    errors.merge!(errors_messages) unless user.valid?
  end

  def user_params
    {
      phone: inputs[:phone],
      address_attributes: address_attributes
    }
  end

  def address_attributes
    inputs.slice(:street_address, :state, :city, :zip_code).compact
  end

  def validate_user_transition
    return if user.may_update_contact_details?
    errors.add(:user, 'Invalid state transition')
  end
end
