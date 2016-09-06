class Transaction < ApplicationRecord
  belongs_to :invoice

  def self.random
    order("RANDOM()").first
  end

  def credit_card_number
    super.to_s
  end
end
