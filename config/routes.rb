# config/routes.rb

Rails.application.routes.draw do
  # Define que a URL raiz ("/") será controlada pela action "index" do BlockchainController
  root 'blockchain#index'

  # Cria uma rota para receber o envio do formulário (POST)
  # A URL será /add_block e será controlada pela action "create"
  post 'add_block', to: 'blockchain#create'
end