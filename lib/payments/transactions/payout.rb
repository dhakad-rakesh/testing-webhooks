# frozen_string_literal: true

module Payments
  module Transactions
    class Payout < ::Payments::Transactions::Base
      attr_reader :amount
      attr_accessor :receiver

      #validates :receiver, presence: true 
    end
  end
end