# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :bank_account

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  after_create :account_creation

  def account_creation
    create_bank_account
  end
end
