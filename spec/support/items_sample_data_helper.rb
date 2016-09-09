module ItemsSampleDataHelper
  def best_day_sample_data
    item = create(:item)
    create_list(:invoice_item, 4, item: item)
    create(:invoice_item, item: item)
    Invoice.
      joins(:invoice_items).
      where(invoice_items: { item: item }).each do |inv|
      inv.update(created_at: "2012-03-16 11:55:05")
    end

    { item: item, day: "2012-03-16 11:55:05" }
  end

  def top_items_sample_data
    item_1, item_2 = create_list(:item, 2)
    create_list(:transaction, 4)
    Transaction.all.each do |trans|
      create(:invoice_item, item: item_1, invoice: trans.invoice)
    end
    failed_invoice = create(:failed_transaction).invoice
    create(:invoice_item, item: item_2, invoice: failed_invoice)

    { item: item_1 }
  end

  def top_three_items_by_revenue
    top_three_merchants_by_revenue.map do |merchant|
      merchant.items.first
    end
  end
end
