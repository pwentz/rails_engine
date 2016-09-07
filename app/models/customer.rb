class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    merchants.
      joins(:transactions).
      where("transactions.result = 'success'").
      joins(:invoice_items).
      select(
        "merchants.*, "\
        "SUM((invoice_items.unit_price / 100) * quantity) AS total"
      ).
      order("total DESC").
      group("merchants.id").
      first
  end
end
