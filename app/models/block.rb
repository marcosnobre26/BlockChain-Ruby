class Block < ApplicationRecord
  has_many :ledger_transactions
end
