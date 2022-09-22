class FundTransferProcess
  
  def initialize(args={})
    @payor = args[:payor]
    @payee = args[:payee]
    @amount = args[:amount].to_f
    @transfer_amount = transfer_amount
    @status = true
  end

  def call
    return [@status, @message] unless valid_transfer_amount
    
    Wallet.transaction do
      @payor.point_wallet.debit(@amount)
      @payee.point_wallet.credit(@transfer_amount)
      
      create_transfer_record

      create_transfer_ledgers

      fail(ActiveRecord::Rollback) unless @status
    end
    
    @message = "Funds transferred to #{@payee.full_name}" if @status
    [@status, @message]
  end

  private
 
  # Creation of ledgers for transfer
  def create_transfer_ledgers
    [[@payor, @amount, "debit"], [@payee, @transfer_amount, "credit"]].each do |user, amount, type|
      genearte_ledgers(user, amount, type)
      
      send_transfer_mails(notify_transfer_mail_params(type), type)
    end
  end

  def genearte_ledgers(user, amount, type)
    Ledgers::GenerateTransferLedgers.new(ledger_params(user, amount, type)).call
  end

  def ledger_params(user, amount, transaction_type)
    remark = remark(transaction_type)
    {
      wallet: user.point_wallet,
      remark: remark,
      transaction_type: transaction_type,
      amount: amount,
      transfer_record_id: @transfer_record.id
    }
  end

  def remark(transaction_type)
    transaction_type === "credit" ? "Recieved funds from #{@payor.full_name.titleize}" : "Sent funds to #{@payee.full_name.titleize}"
  end
  
  # for mailing payor and payee
  def notify_transfer_mail_params(type)
    amount = (type === "debit") ? @amount : @transfer_amount
    {
      payee_id: @transfer_record.payee_id,
      payor_id: @transfer_record.payor_id,
      amount: amount,
      transaction_type: type
    }
  end

  def send_transfer_mails(mail_params, transaction_type)
    TransferNotifyMailer.with(mail_params).send("notify_#{transaction_type}").deliver_later
  end
  
  # for keeping record of transaction
  def create_transfer_record
    @transfer_record = TransferRecord.create!(transfer_record_params)
  end

  def transfer_record_params
    {
      payor_id: @payor.id,
      payee_id: @payee.id,
      amount: @amount,
      actual_transfer: @transfer_amount,
      commision_earned: (@amount - @transfer_amount).round(2)
    }
  end

  # for calculation of amount to transfer
  def valid_transfer_amount
    @status, @message = if @amount <= Constants::MINIMUM_TRANSFERABLE_AMOUNT
                          [false, "Invalid amount."]
                        elsif @payor.point_wallet.available_amount < @amount
                          [false, I18n.t('wallets.not_enough_amount')]
                        else
                          [true, "Valid amount."]
                        end
    @status
  end

  def transfer_amount
    @amount - merchant_cut
  end

  def merchant_cut
    (GammabetSetting.fund_transfer_commision/100)*@amount
  end
end
