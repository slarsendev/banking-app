# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :initialize_user, :user_bank_account
  before_action :account_transactions, except: [:new]
  before_action :payee_info, only: [:transfer_money]

  def index; end

  def new
    @transaction = @bank_account.transactions.new
  end

  def transfer_money
    ActiveRecord::Base.transaction do
      @transactions.create!(transfer_transaction_params)
      @payee_transactions.create!(transfer_transaction_params('credit'))
    end
    redirect_to user_transactions_path

  rescue ActiveRecord::ActiveRecordError => e
    redirect_to new_user_transaction_path, flash: { error: e.message }
  end

  private

  def initialize_user
    @user = User.find_by(id: params[:user_id])
  end

  def user_bank_account
    @bank_account = @user.bank_account
  end

  def account_transactions
    @transactions = @bank_account.transactions
  end

  def payee_info
    @payee = User.find_by_email(params[:transaction][:transfer_to])
    @payee_account = @payee.bank_account
    @payee_transactions = @payee_account.transactions
  end

  def transfer_transaction_params(type = 'debit')
    params.require(:transaction).permit(:amount)
          .merge!(history: "Transferring money from #{@bank_account.id} to #{@payee_account.id}",
                  trans_type: type, trans_mode: 'transfer')
  end
end
