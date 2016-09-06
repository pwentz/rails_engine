class Transaction < ApplicationRecord
  include ActiveModel::Serializers::JSON
  belongs_to :invoice

  def credit_card_number
    super.to_s
  end

  def attributes
    { 'invoice_id': invoice_id,
      'credit_card_number': credit_card_number,
      'result': result,
      'created_at': created_at,
      'id': id,
      'updated_at': updated_at }
  end
end
