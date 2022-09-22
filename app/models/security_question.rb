class SecurityQuestion < ApplicationRecord
  self.per_page = 10
  has_many :security_answers, dependent: :destroy

  before_create :check_question_mark

  scope :created_at_desc, -> { order(created_at: :desc) }
  scope :enabled, -> { where(enabled: true) }

  def check_question_mark
    return if question.include?('?')
    self.question += '?'
  end
end
