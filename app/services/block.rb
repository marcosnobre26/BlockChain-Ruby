# app/services/block.rb

require 'digest'

class Block
  # Adicionamos o :nonce para que possamos lê-lo
  attr_reader :index, :timestamp, :data, :previous_hash, :hash, :nonce

  def initialize(index:, data:, previous_hash:)
    @index = index
    @timestamp = Time.now
    @data = data
    @previous_hash = previous_hash
    @nonce = 0 # O nonce sempre começa em 0
    @hash = calculate_hash
  end

  # Novo método público para mineração
  def mine(difficulty)
    # Cria a string de zeros que o hash deve começar, ex: '00' se a dificuldade for 2
    prefix = '0' * difficulty

    # Loop infinito que só para quando o hash for válido
    until @hash.start_with?(prefix)
      @nonce += 1        # Incrementa o nonce
      @hash = calculate_hash # Recalcula o hash com o novo nonce
    end
  end

  private

  def calculate_hash
    # IMPORTANTE: Agora incluímos o nonce no cálculo do hash!
    payload = @index.to_s + @timestamp.to_s + @data.to_s + @previous_hash.to_s + @nonce.to_s
    
    Digest::SHA256.hexdigest(payload)
  end
end