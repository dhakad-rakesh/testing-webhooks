module Blockchain
  class UpdateUserStatus
    attr_accessor :params, :status, :user, :method_type

    def initialize(params)
      @params = params
      @status = params.dig('data', 'response', 'success')
      @method_type = params.dig('data','methodType')
      @user = 
        if params.dig('data', 'username')
          User.find_by(username: params.dig('data', 'username'))
        else
          User.find_by(deposit_address: params.dig('data', 'depositAddress'))
        end
    end

    def call
      case method_type
      when 'kyc'
        update_kyc
      when 'tfa'
        update_2fa
      when 'transfer'
        update_withdrawal
      when 'deploy'
        update_deposit_address
      end
    end

    private

    def update_kyc
      # response = client.get('getUserKycStatus', status_params)
      # return error_response if response.try(:code) != '200'
      # data = JSON.parse(response.body)
      # kyc_status = data.dig('data','kycStatus') ? 'Approved' : 'Rejected'
      # update_kyc_status(data.dig('data','kycStatus'), kyc_status)
      if status && user.update(kyc_status: 'Approved')
        NotificationMailer.kyc_request_status(user).deliver_later
      else
        user.update(kyc_status: 'Pending')
      end
    end

    def update_kyc_status(blockchain_status, kyc_status)
      if status && user.update(kyc_status: kyc_status)
        NotificationMailer.kyc_request_status(user).deliver_later
        return success_response
      elsif blockchain_status
        user.update(kyc_status: 'Approved')
        return success_response
      else
        user.update(kyc_status: 'Pending')
        return success_response
      end
      error_response
    end

    def update_2fa
      response = client.get('getUserTwoFactorAuthenticationStatus', status_params)
      return error_response if response.try(:code) != '200'
      data = JSON.parse(response.body)
      two_factor_status = data.dig('data','userTwoFactorAuthenticationStatus') ? 'completed' : 'not_done'
      return success_response if user.update(two_factor_status: two_factor_status)
      error_response
    end

    def update_withdrawal
      ledger = Ledger.withdrawal_requests.find_by(id: params.dig('data', 'ledgerId'))
      withdraw_status = status ? 'approved': 'pending'
      if ledger.update(status: withdraw_status, tracking_id: params.dig('data', 'response', 'transactionHash'))
        NotificationMailer.withdraw_request_status(@ledger).deliver_later if status
        return success_response
      end 
      error_response
    end

    def update_deposit_address
      return success_response if user.update(deposit_address: params.dig('data', 'response', 'receipt', 'contractAddress'), deposit_address_request: false)
      error_response
    end

    def success_response
      {success: true}
    end

    def error_response
      {success: false}
    end

    def client
      @client ||= Metamask::Client.new
    end

    def status_params
      {
        "userDepositContractAddress": user.deposit_address
      }
    end
  end
end
