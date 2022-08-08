# frozen_string_literal: true

class CreateBankAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_accounts do |t|
      t.belongs_to :user, foreign: true
      t.decimal :balance, null: false, default: 0.0
      t.check_constraint('balance >= 0.0', name: 'balance_check')

      t.timestamps
    end
  end
end
