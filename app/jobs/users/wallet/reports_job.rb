class Users::Wallet::ReportsJob < ApplicationJob
  queue_as :low

  def perform(*args)
    Wallets::Reports::CreditLimitExeeded.new.generate
    Wallets::Reports::BalanceLimitExeeded.new.generate
  end
end
