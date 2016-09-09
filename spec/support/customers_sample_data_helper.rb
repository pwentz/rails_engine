module CustomersSampleDataHelper
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
end
