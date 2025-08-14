class CreateLedgerTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :ledger_transactions do |t|
      t.string :sender
      t.string :recipient
      t.decimal :amount
      t.references :block, null: false, foreign_key: true

      t.timestamps
    end
  end
end
