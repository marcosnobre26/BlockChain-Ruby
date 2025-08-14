class AllowNullBlockIdOnLedgerTransactions < ActiveRecord::Migration[8.0]
  def change
    #               tabela,         coluna,     permitir_nulo?
    change_column_null :ledger_transactions, :block_id, true
  end
end
