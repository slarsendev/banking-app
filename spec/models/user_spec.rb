require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
  
  describe 'associations' do
    it { should have_one(:bank_account) }
  end

  describe 'callbacks' do
    it { is_expected.to callback(:account_creation).after(:create) }
  end
end
