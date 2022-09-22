require 'rails_helper'

describe Wallets::Base do
  include_context 'common data'
  let(:wallet) { user.point_wallet }
  let(:wallet_base) { Wallets::Base.new(wallet) }

  describe 'credit' do
    it 'returns wallet with updated available amount' do
      wallet_base.credit(1000)
      expect(wallet.available_amount).to eq(11_000)
    end

    it 'should generate an error if no value is passed' do
      expect { wallet_base.credit }.to raise_error(ArgumentError)
    end

    it 'should not update amount or generate an error if the passed argument is a string' do
      expect { wallet_base.credit('abc') }.to_not raise_error
      expect(wallet.available_amount).to eq(10_000)
    end
  end

  describe 'debit' do
    it 'returns wallet with updated available amount' do
      wallet_base.debit(1000)
      expect(wallet.available_amount).to eq(9000)
    end

    it 'returns wallet with original available amount if available amount is less than passed amount' do
      wallet_base.debit(50_000)
      expect(wallet.available_amount).to eq(10_000)
    end

    it 'should return an error if no value is passed' do
      expect { wallet_base.debit }.to raise_error(ArgumentError)
    end
  end

  describe 'persist_wallet!' do
    it 'saves wallet and persists to db' do
      expect(wallet.save).to eq(true)
    end
  end
end
