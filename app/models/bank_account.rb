# frozen_string_literal: true

class BankAccount < ApplicationRecord
  belongs_to :user
  has_many :transactions

  validates :user, presence: true
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
end