# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:bank_account) }

    context 'valid transaction' do
      let(:credit_tran) { build(:transaction, :credit) }
      it 'should save the credit transaction' do
        expect(credit_tran.save).to eq true
      end

      let(:debit_tran) { build(:transaction, :debit) }
      it 'should save the credit transaction' do
        expect(debit_tran.save).to eq true
      end

      let(:invalid_trans) { build(:transaction, :credit, amount: 10_000.0) }
      it 'should not save the transaction as balance in account is lower than credit/debit amount' do
        expect(invalid_trans.save).to eq false
      end
    end
  end

  describe 'scopes' do
    let(:bank_account) { create(:bank_account) }
    let(:credit_tran) { create(:transaction, bank_account: bank_account) }
    let(:debit_tran) do
      create(:transaction, bank_account: bank_account, trans_type: :debit, trans_mode: :withdrawal)
    end

    it 'account should include credit transaction' do
      expect(bank_account.transactions.credit).to include(credit_tran)
      expect(bank_account.transactions.credit).to eq Transaction.where(trans_type: 'credit')
    end

    it 'account should include debit transaction' do
      expect(bank_account.transactions.debit).to include(debit_tran)
      expect(bank_account.transactions.debit).to eq Transaction.where(trans_type: 'debit')
    end

    context 'transfer transaction from A1 - A2' do
      let(:debit_tran) { create(:transaction, :debit_transfer, bank_account: bank_account) }
      it 'account should include debit transaction from Account 1' do
        expect(bank_account.transactions.transfer).to include(debit_tran)
        expect(bank_account.transactions.transfer).to eq Transaction.where(trans_type: 'debit', trans_mode: 'transfer')
      end
    end
  end

  describe 'callbacks' do
    it { is_expected.to callback(:generate_transaction_number).before(:validation) }
    it { is_expected.to callback(:update_account_balance).after(:create) }
  end

  describe 'associations' do
    it { should belong_to(:bank_account) }
  end

  describe 'types' do
    it { should define_enum_for(:trans_type).with_values(%i[debit credit]) }
    it { should define_enum_for(:trans_mode).with_values(%i[deposit withdrawal transfer]) }
  end
end
