class CreateBlocks < ActiveRecord::Migration[8.0]
  def change
    create_table :blocks do |t|
      t.integer :index
      t.string :previous_hash
      t.string :block_hash
      t.datetime :timestamp
      t.text :data
      t.integer :nonce

      t.timestamps
    end
  end
end
