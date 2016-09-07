class Merchant < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.most_items_sold(quantity)
    select("merchants.*, SUM(invoice_items.quantity) AS most_items").
      joins(:invoice_items).
      order("most_items DESC").
      group("merchants.id").
      first(quantity)
  end

  def revenue
    { "revenue" => calculate_revenue }
  end

  def calculate_revenue
    number_with_precision(
      invoices.
      joins(:transactions).
      where(
        "transactions.result = 'success'"
      ).
      joins(:invoice_items).
      sum(
        '(invoice_items.unit_price::float / 100) * quantity'
      ),
      precision: 2
    )
  end

  def customers_with_pending_invoices
    customers.
      joins(:invoices).
      joins(
        "INNER JOIN transactions ON " \
        "transactions.invoice_id = invoices.id"
      ).
      merge(Transaction.
      unsuccessful).
      distinct
  end
end
