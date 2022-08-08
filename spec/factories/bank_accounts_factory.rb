# frozen_string_literal: true

FactoryBot.define do
  factory :bank_account do
    user { FactoryBot.create(:user) }
    balance { 1000 }
  end
end
