# app/services/blockchain.rb

require_relative 'block'

class Blockchain
  # Adicionamos a :difficulty
  attr_reader :chain, :difficulty

  # Agora nosso construtor aceita um nível de dificuldade
  def initialize(difficulty: 2)
    @chain = [create_genesis_block]
    @difficulty = difficulty # Padrão é 2, mas pode ser mudado
  end

  def add_block(data:)
    previous_block = @chain.last
    new_block = Block.new(
      index: previous_block.index + 1,
      data: data,
      previous_hash: previous_block.hash
    )
    
    # === A GRANDE MUDANÇA ESTÁ AQUI ===
    # Antes de adicionar o bloco à cadeia, nós o mineramos.
    new_block.mine(@difficulty)
    
    @chain.push(new_block)
  end

  private

  def create_genesis_block
    # O bloco Gênesis não precisa ser minerado (é a regra de origem)
    Block.new(index: 0, data: 'Bloco Gênesis', previous_hash: '0')
  end
end