class Transaction < ApplicationRecord
  belongs_to :invoice

  def credit_card_number
    super.to_s
  end
end
