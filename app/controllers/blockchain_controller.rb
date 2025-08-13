require_relative '../services/blockchain'

class BlockchainController < ApplicationController
  @@blockchain ||= Blockchain.new(difficulty: 2)

  def index
    @chain = @@blockchain.chain
  end

  def create
    @@blockchain.add_block(data: params[:data])

    redirect_to root_path
  end
end