require 'rails_helper'
describe BetProcess do
  include_context 'common data'

  describe 'call' do
    before(:each) do
      wallet.update(available_amount: 5000)

      (1..3).each do |cache_id|
        allow(Rails.cache).to receive(:fetch).with(send("cache_key_#{cache_id}".to_sym)).and_return(cached_response)
      end
    end

    it 'should not call betprocess with insufficient wallet amount' do
      wallet.update(available_amount: 0)
      betprocess = BetProcess.new(user: user, bet_slips: [bet_slip])
      status, message = betprocess.call
      expect(status).to eq(false)
      expect(message).to eq(I18n.t('wallets.not_enough_amount'))
    end

    it 'should create Bet if all bet params are valid' do
      wallet.update(available_amount: 1000)
      allow_any_instance_of(Match).to receive(:betting_status).and_return('0')

      betprocess = BetProcess.new(user: user, bet_slips: [bet_slip])
      expect(Bet.count).to be(0)
      expect(wallet.ledgers.count).to be(0)
      betprocess.call

      expect(Bet.count).to be(1)
      expect(wallet.ledgers.count).to be(1)
    end

    it 'should not create Bet with invalid match_id' do
      allow(Rails.cache).to receive(:fetch).and_return(nil)
      allow_any_instance_of(Match).to receive(:betting_status).and_return('0')

      betprocess = BetProcess.new(user: user, bet_slips: [bet_slip.merge!(match_id: nil)])
      expect { betprocess.call }.to change(Bet, :count).by(0)
    end

    it 'should not create bet without invalid market_id' do
      allow_any_instance_of(Match).to receive(:betting_status).and_return('0')

      betprocess = BetProcess.new(user: user, bet_slips: [bet_slip.merge!(market_id: nil)])
      expect { betprocess.call }.to change(Bet, :count).by(0)
    end

    it 'should not create bet without invalid betting status' do
      betprocess = BetProcess.new(user: user, bet_slips: [bet_slip])
      expect { betprocess.call }.to change(Bet, :count).by(0)
    end

    it 'should not create bet without invalid odds' do
      allow_any_instance_of(Match).to receive(:betting_status).and_return('0')

      betprocess = BetProcess.new(user: user, bet_slips: [bet_slip.merge!(odds: nil)])
      expect { betprocess.call }.to change(Bet, :count).by(0)
    end

    it 'should not create bet without invalid outcome' do
      allow_any_instance_of(Match).to receive(:betting_status).and_return('0')

      betprocess = BetProcess.new(user: user, bet_slips: [bet_slip.merge!(outcome_id: nil)])
      expect { betprocess.call }.to change(Bet, :count).by(0)
    end

    it 'should not create bet without invalid identifier' do
      allow_any_instance_of(Match).to receive(:betting_status).and_return('0')

      betprocess = BetProcess.new(user: user, bet_slips: [bet_slip.merge!(identifier: nil)])
      expect { betprocess.call }.to change(Bet, :count).by(0)
    end
  end
end
