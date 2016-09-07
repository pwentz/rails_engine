class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  default_scope { order(id: :desc) }

  def self.most_revenue(quantity)
    unscoped.
      select(
        "items.*, "\
        "SUM((invoice_items.unit_price::float / 100) "\
        "* invoice_items.quantity) AS revenue"
      ).
      joins(:transactions).
      where("transactions.result = 'success'").
      joins(:invoice_items).
      order("revenue DESC").
      group("items.id").
      first(quantity)
  end

  def unit_price
    (super.to_f / 100).to_s
  end
end
