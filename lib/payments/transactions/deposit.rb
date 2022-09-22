# frozen_string_literal: true

module Payments
  module Transactions
    class Deposit < ::Payments::Transactions::Base
      attr_reader :amount
      attr_accessor :promo_code, :transaction_hash
    end
  end
end