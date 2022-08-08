# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:balance) }
    it { should validate_numericality_of(:balance).is_greater_than_or_equal_to(0.0) }
  end
  
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:transactions) }
  end
end
