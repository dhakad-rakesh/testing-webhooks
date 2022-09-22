# frozen_string_literal: true

module Payments
  module Transactions
    class Base
      include ::ActiveModel::Model

      attr_accessor :id, :method, :amount, :user, :currency,
                    :initiator, :comment, :status

      # validates :method, :user, :amount, :currency, presence: true
      validates :user, :amount, presence: true
      validates :amount, numericality: true

      def wallet
        @wallet ||= user.point_wallet
      end
    end
  end
end
