class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.most_items_sold(quantity)
    Merchant.select("merchants.*, SUM(invoice_items.quantity) AS most_items").
      joins(:invoice_items).order("most_items DESC").group("merchants.id").first(quantity)
  end
end
