# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :bank_account

  validate :initiate_transaction, on: :create
  validates :bank_account, presence: true

  before_validation :generate_transaction_number, on: :create
  after_create :update_account_balance

  enum trans_type: { debit: 0, credit: 1 }
  enum trans_mode: { deposit: 0, withdrawal: 1, transfer: 2 }

  scope :debit, -> { where(trans_type: 'debit') }
  scope :credit, -> { where(trans_type: 'credit') }
  scope :transfer, -> { debit.where(trans_mode: 'transfer') }

  def readonly?
    !new_record?
  end
  
  def generate_transaction_number
    self.transaction_number = SecureRandom.uuid
  end

  def initiate_transaction
    errors.add(:transaction, "is invalid") if self.trans_type == 'debit' && self.amount >= bank_account.balance
  end

  def update_account_balance
    balance = self.trans_type == 'debit' ? bank_account.balance - self.amount : bank_account.balance + self.amount
    bank_account.update(balance: balance)
  end
end



