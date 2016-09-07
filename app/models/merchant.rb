class Merchant < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.most_items_sold(quantity)
    select("merchants.*, SUM(invoices.quantity) AS most_items").
      joins(:invoices).
      joins(:transactions).
      where("transactions.result = 'success'").
      order("most_items DESC").
      group("merchants.id").
      first(quantity)
  end

  def revenue(date)
    if date
      { "revenue" => revenue_on_date(date.to_time.utc) }
    else
      { "revenue" => calculate_revenue }
    end
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

  def revenue_on_date(date)
    number_with_precision(
      invoices.
      where(
        'invoices.created_at >= ? AND '\
        'invoices.created_at <= ?',
        date.beginning_of_day,
        date.end_of_day
      ).
      joins(:invoice_items, :transactions).
      where("transactions.result = 'success'").
      sum(
        '(invoice_items.unit_price::float / 100) '\
        '* invoice_items.quantity'
      ),
      precision: 2
    )
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
end
