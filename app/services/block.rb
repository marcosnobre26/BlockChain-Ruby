require "digest"

class Block
  attr_reader :index, :timestamp, :data, :previous_hash, :hash, :nonce

  def initialize(index:, data:, previous_hash:)
    @index = index
    @timestamp = Time.now
    @data = data
    @previous_hash = previous_hash
    @nonce = 0
    @hash = calculate_hash
  end

  def mine(difficulty)
    prefix = "0" * difficulty

    until @hash.start_with?(prefix)
      @nonce += 1
      @hash = calculate_hash
    end
  end

  private

  def calculate_hash
    payload = @index.to_s + @timestamp.to_s + @data.to_s + @previous_hash.to_s + @nonce.to_s

    Digest::SHA256.hexdigest(payload)
  end
end
