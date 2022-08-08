# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  describe '#index' do
    context 'when user signed in' do
      before do
        sign_in user
      end

      it 'returns all transactions' do
        get :index, params: { user_id: user.id }
        expect(response).to have_http_status(200)
        expect(assigns(:user)).to eq user
        expect(assigns(:bank_account)).to eq user.bank_account
        expect(assigns(:transactions)).to eq user.bank_account.transactions
      end
    end

    context 'when user is not sign out' do
      it 'will throw an error' do
        get :index, params: { user_id: user.id }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe '#new' do
    context 'when user is not sign out' do
      it 'will throw an error' do
        get :new, params: { user_id: user.id }
        expect(response).to have_http_status(302)
      end
    end

    context 'when user signed in' do
      before do
        sign_in user
      end

      it 'returns new instance of transaction' do
        get :new, params: { user_id: user.id }
        expect(response).to have_http_status(200)
        expect(assigns(:user)).to eq user
        expect(assigns(:bank_account)).to eq user.bank_account
        expect(assigns(:transaction).id).to eq nil
      end
    end
  end

  describe '#transfer_money' do
    before do
      sign_in user
    end

    let(:payee) { FactoryBot.create(:user) }
    it "transfer money from user's account to payee account" do
      user.bank_account.update(balance: 1000)
      post :transfer_money, params: { user_id: user.id, transaction: { amount: 100, transfer_to: payee.email } }

      expect(response).to have_http_status(302)
    end

    it "failed to transfer money 'invalid transaction' as account balance is low" do
      post :transfer_money, params: { user_id: user.id, transaction: { amount: 100, transfer_to: payee.email } }
  
      expect(response).to have_http_status(302)
    end
  end
end
