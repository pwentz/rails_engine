class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  default_scope { order(id: :desc) }

  def self.most_revenue(quantity)
    select(
      "items.*, " \
      "SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue"
    ).
      joins(:invoice_items).
      order("revenue DESC").
      group("items.id").
      first(quantity)
  end

  def self.top_items_by_number_sold(quantity)


  end

  def unit_price
    (super.to_f / 100).to_s
  end
end
