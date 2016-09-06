class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  def unit_price
    (super.to_f / 100).to_s
  end
end
