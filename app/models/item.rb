class Item < ApplicationRecord
  include ActiveModel::Serializers::JSON
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  default_scope { order(id: :desc) }

  def self.most_revenue(quantity)
    unscoped.
      select(
        "items.*, " \
        "SUM(invoice_items.unit_price " \
        "* invoice_items.quantity) AS revenue"
      ).
      joins(:transactions, :invoice_items).
      merge(Transaction.successful).
      order("revenue DESC").
      group("items.id").
      first(quantity)
  end

  def self.top_items_by_number_sold(quantity)
    unscoped.
      select("items.*, SUM(invoice_items.quantity) AS most_items").
      joins(:transactions, :invoice_items).
      merge(Transaction.successful).
      order("most_items DESC").
      group("items.id").
      first(quantity)
  end

  def best_day
    invoices.
      includes(:invoice_items).
      order("invoice_items.quantity DESC, invoices.created_at DESC").
      first.
      created_at
  end
end
