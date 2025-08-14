class ChainValidator
  DIFFICULTY = 2

  def self.call
    blocks = Block.order(index: :asc)
    
    blocks.each_with_index do |block, current_index|
      if current_index == 0
        unless genesis_block_valid?(block)
          puts "ERRO: O Bloco Gênesis foi adulterado!"
          return false
        end
        next
      end

      previous_block = blocks[current_index - 1]

      if block.previous_hash != previous_block.block_hash
        puts "ERRO: Elo quebrado no Bloco ##{block.index}. O hash do bloco anterior não corresponde."
        return false
      end

      if calculate_hash_for(block) != block.block_hash
        puts "ERRO: A Prova de Trabalho do Bloco ##{block.index} é inválida. Os dados foram adulterados."
        return false
      end
    end

    puts "SUCESSO: A cadeia de blocos foi verificada e é válida."
    return true
  end

  private

    def self.genesis_block_valid?(block)
        calculate_hash_for(block) == block.block_hash
    end

    def self.calculate_hash_for(block)
        payload = "#{block.index}#{block.timestamp.to_i}#{block.data}#{block.previous_hash}#{block.nonce}"
        Digest::SHA256.hexdigest(payload)
    end
end