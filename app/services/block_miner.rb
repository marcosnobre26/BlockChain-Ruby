class BlockMiner
  DIFFICULTY = 2

  def self.call(pending_transactions)
    puts "Verificando #{pending_transactions.count} transações pendentes..."
    verified_transactions = pending_transactions.select do |tx|
      if tx.signature_valid?
        true
      else
        puts "AVISO: Transação ID##{tx.id} com assinatura inválida foi descartada."
        false
      end
    end
    puts "#{verified_transactions.count} transações foram verificadas com sucesso."

    if verified_transactions.empty? && Block.any?
      return nil
    end

    last_block = Block.last

    if last_block.nil?
      index = 0
      previous_hash = "0"
      data_payload = "Bloco Gênesis"
    else
      index = last_block.index + 1
      previous_hash = last_block.block_hash
      data_payload = verified_transactions.map(&:attributes).to_json
    end

    nonce = 0
    timestamp = Time.now
    block_hash = ""
    prefix = "0" * DIFFICULTY

    loop do
      payload = "#{index}#{timestamp.to_i}#{data_payload}#{previous_hash}#{nonce}"
      block_hash = Digest::SHA256.hexdigest(payload)
      break if block_hash.start_with?(prefix)
      nonce += 1
    end

    new_block = nil
    ActiveRecord::Base.transaction do
      new_block = Block.create!(
        index: index,
        timestamp: timestamp,
        data: data_payload,
        previous_hash: previous_hash,
        block_hash: block_hash,
        nonce: nonce
      )

      verified_transactions.each { |tx| tx.update!(block: new_block) }
    end

    new_block
  end
end
