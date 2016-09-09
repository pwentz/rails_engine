module MerchantRevenueSampleDataHelper
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

  def top_three_merchants_by_revenue(date = {})
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
