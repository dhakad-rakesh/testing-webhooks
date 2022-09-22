module NumberService

  def self.round_to_2_decimal(amount)
    "%.2f" % BigDecimal(amount.to_f.to_s).round(2, :truncate).to_f
  end

  def self.round_to_8_decimal(amount)
    "%.8f" % BigDecimal(amount.to_f.to_s).round(8, :truncate).to_f
  end

end
