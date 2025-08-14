class LedgerTransactionsController < ApplicationController
  
  before_action :authenticate_user!

  def new
    
    @ledger_transaction = LedgerTransaction.new
    
    
    @sender_address = current_user.public_key
  end

  def create
    @ledger_transaction = LedgerTransaction.new(ledger_transaction_params)

    begin
      private_key = OpenSSL::PKey::RSA.new(current_user.private_key)
      payload = "#{@ledger_transaction.sender}#{@ledger_transaction.recipient}#{@ledger_transaction.amount}"
      signature = private_key.sign('SHA256', payload)
      @ledger_transaction.signature = Base64.strict_encode64(signature)
    rescue OpenSSL::PKey::RSAError
      @ledger_transaction.errors.add(:base, "Chave privada inválida.")
      render :new, status: :unprocessable_entity and return
    end

    if @ledger_transaction.save
      redirect_to root_path, notice: 'Transação assinada e enviada para o Mempool.'
    else
      @sender_address = current_user.public_key
      render :new, status: :unprocessable_entity
    end
  end

  private

  def ledger_transaction_params
    params.require(:ledger_transaction).permit(:sender, :recipient, :amount)
  end
end