Rails.application.routes.draw do
  root 'blockchain#index'
  post 'add_block', to: 'blockchain#create'
  resources :ledger_transactions, only: [:new, :create]
  get 'validate_chain', to: 'blockchain#validate_chain'

  get 'my_wallet', to: 'users#show'

  devise_for :users
end