class LedgerTransaction < ApplicationRecord
  belongs_to :block, optional: true


  validates :sender, presence: true
  validates :recipient, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }


  scope :pending, -> { where(block_id: nil) }

  def signature_valid?
    return false if sender.blank? || signature.blank?

    begin

      public_key = OpenSSL::PKey::RSA.new(sender)


      decoded_signature = Base64.strict_decode64(signature)


      payload = "#{sender}#{recipient}#{amount}"


      public_key.verify("SHA256", decoded_signature, payload)
    rescue OpenSSL::PKey::RSAError, ArgumentError

      false
    end
  end
end
