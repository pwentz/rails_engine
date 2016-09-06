class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity)
    Item.select(
      "items.*, "\
      "SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue"
      ).
      joins(:invoice_items).
      order("revenue DESC").
      group("items.id").
      first(quantity)
  end
end
