require 'openssl'

class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :generate_key_pair

  private

  def generate_key_pair
    
    key_pair = OpenSSL::PKey::RSA.new(2048)

    
    new_public_key = key_pair.public_key.to_pem
    new_private_key = key_pair.to_pem

    update_columns(public_key: new_public_key, private_key: new_private_key)
  end
end