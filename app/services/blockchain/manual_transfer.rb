module Blockchain
  class ManualTransfer
    attr_accessor :admin_user, :amount, :wagered_amount

    def initialize(admin, amount, wagered_amount = 0.0)
      @admin_user = admin
      @amount = amount.to_f
      @wagered_amount = wagered_amount.to_f
    end

    def call
      ActiveRecord::Base.transaction do
        create_ledger
        @ledger.update!(tracking_id: "Ledger-#{@ledger.id}")
        update_admin_wagered
        response = client.post('transfer', transfer_params)
        data = JSON.parse(response.body)
        if data['success']
          return [true,'Amount transferred request initiated successfully'] 
        else
          raise ActiveRecord::Rollback
        end
      end
      return [false,'Amount transferred failed from blockchain']
    rescue Exception => e
      [false, t('went_wrong')]
    end

    private

    def create_ledger
      @ledger = transaction.user.current_wallet.ledgers.create!(
        amount: transaction.amount,
        betable: transaction.user,
        transaction_type: 'credit',
        mode: transaction.method,
        status: 'initiated',
        account_details: transaction.receiver,
        remark: "Affiliate commision for #{wagered_amount.round(6)} wagered amount"
      )
    end

    def transaction
        ::Payments::Transactions::Payout.new(
          user: admin_user,
          amount: amount.to_f,
          receiver: admin_user.reciever_address
        )
    end

    def client
      @client ||= Metamask::Client.new
    end

    def transfer_params
     {
      "receiverAddress": admin_user.reciever_address,
      "amount": amount.to_f,
      "ledgerId": @ledger.id
      }
    end 

    def update_admin_wagered
      admin_wallet = admin_user.current_wallet
      admin_wallet.wagered_amount += wagered_amount
      admin_wallet.save!
    end
  end
end
