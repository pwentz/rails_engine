module SampleDataHelper
  def favorite_merchant_sample_data
    customer = create(:customer)
    merchant_1, merchant_2 = create_list(:merchant, 2)
    3.times do |i|
      if i < 2
        invoice =
          create(:invoice, customer: customer, merchant: merchant_1)
        create(:transaction, invoice: invoice)
      else
        invoice =
          create(:invoice, customer: customer, merchant: merchant_2)
        create(:transaction, invoice: invoice)
      end
    end
    { customer: customer, merchant_1: merchant_1 }
  end

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

  def merchant_revenue(date = {})
    sample_merchant = create(:merchant)

    if date.empty?
      invoice_one,
      invoice_two = create_list(:invoice, 2, merchant: sample_merchant)
    else
      invoice_one = create(
        :invoice,
        merchant: sample_merchant,
        created_at: DateTime.new(date[:year],
                                 date[:month],
                                 date[:day][0])
      )

      invoice_two = create(
        :invoice,
        merchant: sample_merchant,
        created_at: DateTime.new(date[:year],
                                 date[:month],
                                 date[:day][1])
      )
    end

    item_one = create(
      :item,
      merchant: sample_merchant,
      unit_price: 500
    )
    item_two = create(
      :item,
      merchant: sample_merchant,
      unit_price: 250
    )

    create(
      :invoice_item,
      quantity: 2,
      invoice: invoice_one,
      item: item_one,
      unit_price: item_one.unit_price
    )
    create(
      :invoice_item,
      quantity: 4,
      invoice: invoice_two,
      item: item_two,
      unit_price: item_two.unit_price
    )

    create(:transaction, invoice: invoice_one)
    create(:transaction, invoice: invoice_two)
  end

  def top_merchants(date = {})
    merchant_one,
    merchant_two,
    merchant_three = create_list(:merchant, 3)

    if date.empty?
      invoice_one = create(:invoice, merchant: merchant_one)
      invoice_two = create(:invoice, merchant: merchant_two)
      invoice_three = create(:invoice, merchant: merchant_three)
    else
      invoice_one = create(
        :invoice,
        merchant: merchant_one,
        created_at: DateTime.new(date[:year],
                                 date[:month],
                                 date[:day][0])
      )
      invoice_two = create(
        :invoice,
        merchant: merchant_two,
        created_at: DateTime.new(date[:year],
                                 date[:month],
                                 date[:day][0])
      )
      invoice_three = create(
        :invoice,
        merchant: merchant_three,
        created_at: DateTime.new(date[:year],
                                 date[:month],
                                 date[:day][1])
      )
    end

    item_one = create(
      :item,
      unit_price: 500,
      merchant: merchant_one
    )
    item_two = create(
      :item,
      unit_price: 200,
      merchant: merchant_two
    )
    item_three = create(
      :item,
      unit_price: 100,
      merchant: merchant_three
    )

    create(:transaction, invoice: invoice_one)
    create(:transaction, invoice: invoice_two)
    create(:transaction, invoice: invoice_three)

    create(
      :invoice_item,
      quantity: 7,
      unit_price: item_one.unit_price,
      item: item_one,
      invoice: invoice_one
    )
    create(
      :invoice_item,
      quantity: 2,
      unit_price: item_two.unit_price,
      item: item_two,
      invoice: invoice_two
    )
    create(
      :invoice_item,
      quantity: 6,
      unit_price: item_three.unit_price,
      item: item_three,
      invoice: invoice_three
    )

    [merchant_one, merchant_two, merchant_three]
  end
end
