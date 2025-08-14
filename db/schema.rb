# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_14_022831) do
  create_table "blocks", force: :cascade do |t|
    t.integer "index"
    t.string "previous_hash"
    t.string "block_hash"
    t.datetime "timestamp"
    t.text "data"
    t.integer "nonce"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ledger_transactions", force: :cascade do |t|
    t.string "sender"
    t.string "recipient"
    t.decimal "amount"
    t.integer "block_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "signature"
    t.index ["block_id"], name: "index_ledger_transactions_on_block_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "public_key"
    t.text "private_key"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "ledger_transactions", "blocks"
end
