class WalletSerializer < BaseSerializer
  attributes :amount, :wallet_type, :currency, :latest_credit, :latest_debit, :bonus, :blocked_amount
end
