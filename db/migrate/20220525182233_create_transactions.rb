# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :bank_account, foreign_key: true
      t.string :transaction_number, null: false, unique: true
      t.string :history, null: false
      t.integer :trans_type, null: false, index: true
      t.integer :trans_mode, null: false, index: true
      t.decimal :amount, null: false
      t.check_constraint('amount >= 0.0', name: 'amount_check')

      t.timestamps
    end
  end
end
