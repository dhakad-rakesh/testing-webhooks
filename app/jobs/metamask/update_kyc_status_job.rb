class Metamask::UpdateKycStatusJob < ApplicationJob
  queue_as :high

  def perform(user, old_status, status)
    @user = user
    @status = status
    response = client.post('setUserKycStatus', status_params)
    return update_status(old_status) if response.try(:code) != '200'
    data = JSON.parse(response.body)
    if data['success']
      update_status(status)     
      NotificationMailer.kyc_request_status(@user).deliver_later if @user.kyc_approved? || @user.kyc_rejected?
    else
      update_status(old_status)
    end
  end

  private

  def client
    @client ||= Metamask::Client.new
  end

  def status_params
    {
    "userDepositContractAddress": @user.deposit_address,
    "kycStatus": @status.eql?('Approved')
    }
  end

  def update_status(status)
    @user.update(kyc_status: status)
  end
end
