# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    bank_account { FactoryBot.create(:bank_account) }
    amount { 100 }
    history { 'cash' }
    trans_type { :credit }
    trans_mode { :deposit }

    trait 'debit_transfer' do
      history { 'A1 - A2' }
      trans_type { :debit }
      trans_mode { :transfer }
    end
    trait 'credit_transfer' do
      history { 'A1 - A2' }
      trans_type { :credit }
      trans_mode { :transfer }
    end
    trait 'debit' do
      history { 'cash withdrawal' }
      trans_type { :debit }
      trans_mode { :withdrawal }
    end
    trait 'credit' do
      history { 'cash deposit' }
      trans_type { :debit }
      trans_mode { :deposit }
    end
  end
end
