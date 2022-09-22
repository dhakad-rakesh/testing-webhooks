require 'rails_helper'

describe Api::ScoresController do
  let!(:user) { FactoryBot.create(:user) }
  let!(:token) { user.generate_access_token.token }
  let!(:match) { FactoryBot.create(:match) }

  before(:each) do
    request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
  end

  it 'should return scores' do
    match.update(status: 'started')
    get :index
    result = JSON.parse(response.body)
    expect(response.status).to be(200)
    expect(result).to include('matches')
    expect(result['matches'].present?).to be_truthy
  end

  it 'should not return scores' do
    get :index
    result = JSON.parse(response.body)
    expect(response.status).to be(200)
    expect(result['matches'].present?).to be_falsey
  end
end
