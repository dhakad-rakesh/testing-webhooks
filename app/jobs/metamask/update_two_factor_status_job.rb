class Metamask::UpdateTwoFactorStatusJob < ApplicationJob
  queue_as :high

  def perform(user, params)
    response = client.post('setUserTwoFactorAuthenticationStatus', params)
    return if response.try(:code) != '200'
    data = JSON.parse(response.body)
    status = params[:twoFactorAuthenticationStatus].present? ? 2 : 0
    user.update(two_factor_status: status) if data['success']
  end

  private

  def client
    @client ||= Metamask::Client.new
  end
end
