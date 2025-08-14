require_relative 'block'

class Blockchain

  attr_reader :chain, :difficulty

  def initialize(difficulty: 2)
    @chain = [create_genesis_block]
    @difficulty = difficulty
  end

  def add_block(data:)
    previous_block = @chain.last
    new_block = Block.new(
      index: previous_block.index + 1,
      data: data,
      previous_hash: previous_block.hash
    )
    
    new_block.mine(@difficulty)
    
    @chain.push(new_block)
  end

  private

  def create_genesis_block
    Block.new(index: 0, data: 'Bloco Gênesis', previous_hash: '0')
  end
end