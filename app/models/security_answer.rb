class SecurityAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :security_question
  validates :user_id,
    uniqueness: { scope: %I[security_question_id], message: 'You answered this question' }
end
