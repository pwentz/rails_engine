class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    merchants.
      select("merchants.*, count(transactions.id) AS trans_count").
      joins(:transactions).
      where("transactions.result = 'success'").
      group("merchants.id").
      order("trans_count DESC").
      first
  end
end
