# frozen_string_literal: true

module Users
  class AvailableDepositMethods
    def initialize(user:)
      @user = user
    end

    def call
      deposit_methods.compact
    end

    private

    attr_reader :user

    def deposit_methods
      ::Payments::Deposit::PAYMENT_METHODS.map do |payment_method|

        OpenStruct.new(
          name: payment_method,
          currency: user_currency
        )
      end
    end
  end
end
