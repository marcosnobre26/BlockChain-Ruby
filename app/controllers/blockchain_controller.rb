require_relative "../services/block_miner"

class BlockchainController < ApplicationController
  def index
    @blocks = Block.includes(:ledger_transactions).order(index: :asc)
  end

  def validate_chain
    is_valid = ChainValidator.call

    if is_valid
      redirect_to root_path, notice: "SUCESSO: A cadeia de blocos é válida."
    else
      redirect_to root_path, alert: "ALERTA: A cadeia de blocos está corrompida! Verifique o log do servidor para detalhes."
    end
  end

  def create
    pending_transactions = LedgerTransaction.pending.to_a


    if pending_transactions.empty? && Block.any?
      redirect_to root_path, alert: "Nenhuma transação pendente para minerar."
      return
    end


    new_block = BlockMiner.call(pending_transactions)

    if new_block
      redirect_to root_path, notice: "Bloco ##{new_block.index} minerado com sucesso!"
    else

      redirect_to root_path, alert: "Ocorreu um erro ao minerar o bloco."
    end
  end
end
