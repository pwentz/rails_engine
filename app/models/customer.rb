class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    merchants.
      joins(:transactions).
      merge(Transaction.successful).
      select("merchants.*, COUNT(transactions.result) AS total").
      order("total DESC").
      group("merchants.id").
      first
  end
end
