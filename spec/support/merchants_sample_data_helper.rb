module MerchantsSampleDataHelper
  def customers_with_pending_invoices
    merchant = create(:merchant)
    shipped_invoice_customer = create(:customer)
    pending_invoice_customer = create(:customer)
    shipped_invoice_customer.invoices.create(
      status: 'shipped',
      merchant: merchant
    )
    pending_invoice_customer.invoices.create(
      status: 'pending',
      merchant: merchant
    )
    create(
      :transaction,
      invoice: pending_invoice_customer.invoices.first,
      result: 'failed'
    )
    create(
      :transaction,
      invoice: shipped_invoice_customer.invoices.first
    )
  end

  def favorite_customer_sample_data
    merchant = create(:merchant)
    customer = create(:customer)
    favorite_customer = create(:customer)
    invoice = create(
      :invoice,
      customer: customer,
      merchant: merchant
    )
    favorite_customer_invoice = create(
      :invoice,
      customer: favorite_customer,
      merchant: merchant
    )
    create(
      :transaction,
      invoice: invoice
    )
    create_list(
      :transaction,
      2,
      invoice: favorite_customer_invoice
    )

    favorite_customer
  end

  def pending_invoice_customer(merchant)
    merchant.
      customers.
      joins(:invoices).
      where(invoices: { status: 'pending' }).
      first
  end

  def top_three_merchants_by_items_sold
    top_three_merchants_by_revenue

    Merchant.joins(:invoice_items).
      select('merchants.*, SUM(invoice_items.quantity) AS total').
      order('total DESC').
      group('merchants.id')
  end
end
