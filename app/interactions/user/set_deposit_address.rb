class User::SetDepositAddress < ApplicationInteraction
  object :user

  def execute
    response = client.post('generateAddress', address_params)
    return error_response if response.try(:code) != "200"
    data = JSON.parse(response.body)
  end

  def address_params
   {"userId": user.id.to_s}
  end

  def client
    @client ||= Metamask::Client.new
  end

  def error_response      
    errors.add(:base, 'Something went wrong')
  end
end
