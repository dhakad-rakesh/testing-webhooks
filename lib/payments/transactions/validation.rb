# frozen_string_literal: true

module Payments
  module Transactions
    class Validation
      include ::ActiveModel::Model

      attr_accessor :method, :user, :currency

      validates :method, :user, :currency, presence: true
    end
  end
end
