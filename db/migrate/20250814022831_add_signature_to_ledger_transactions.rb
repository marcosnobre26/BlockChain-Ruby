class AddSignatureToLedgerTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :ledger_transactions, :signature, :text
  end
end
