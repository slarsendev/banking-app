# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    root 'devise/sessions#new'
  end

  resources :users, only: [:show] do
    resources :transactions, only: %i[index new] do
      collection do
        post :transfer_money
      end
    end
  end
end
