class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.most_items_sold(quantity)
    select("merchants.*, SUM(invoice_items.quantity) AS most_items").
      joins(invoices: [:transactions, :invoice_items]).
      merge(Transaction.successful).
      order("most_items DESC").
      group("merchants.id").
      first(quantity)
  end

  def revenue
    invoices.
      joins(:transactions, :invoice_items).
      merge(Transaction.successful).
      sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def customers_with_pending_invoices
    customers.
      joins(:invoices).
      joins(
        "INNER JOIN transactions ON " \
        "transactions.invoice_id = invoices.id"
      ).
      merge(Transaction.unsuccessful).
      distinct
  end

  def revenue_on_date(date)
    invoices.
      where(invoices: { created_at: date }).
      joins(:invoice_items, :transactions).
      merge(Transaction.successful).
      sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def favorite_customer
    customers.
      select(
        "customers.*, SUM(CASE transactions.result WHEN " \
        "'success' THEN 1 ELSE 0 END) AS total_successful_trans"
      ).
      joins(:transactions).
      group("customers.id").
      order("total_successful_trans DESC").
      first
  end

  def self.most_revenue(num_records_to_return)
    joins(:invoice_items).
      select(
        "merchants.*, SUM(invoice_items.unit_price * " \
        "invoice_items.quantity) AS total_revenue"
      ).
      group("merchants.id").
      order("total_revenue DESC").
      first(num_records_to_return)
  end

  def self.revenue_on_date(date)
    joins(invoices: [:transactions, :invoice_items]).
      where(invoices: { created_at: date }).
      merge(Transaction.successful).
      sum("invoice_items.unit_price * invoice_items.quantity")
  end
end
