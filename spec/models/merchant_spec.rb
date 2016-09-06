require 'rails_helper'

RSpec.describe Merchant, type: :model do
  context 'associations' do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  it 'returns the top ranked x merchants by total items sold' do
    merchant_one,
    merchant_two,
    merchant_three = create_list(:merchant, 3)

    invoice_one = create(:invoice, merchant: merchant_one)
    invoice_two = create(:invoice, merchant: merchant_two)
    invoice_three = create(:invoice, merchant: merchant_three)

    item_one = create(:item, merchant: merchant_one)
    item_two = create(:item, merchant: merchant_two)
    item_three = create(:item, merchant: merchant_three)

    create(
      :invoice_item,
      quantity: 7,
      item: item_one,
      invoice: invoice_one
    )
    create(
      :invoice_item,
      quantity: 2,
      item: item_two,
      invoice: invoice_two
    )
    create(
      :invoice_item,
      quantity: 6,
      item: item_three,
      invoice: invoice_three
    )

    expect(
      Merchant.most_items_sold(2)
    ).to eq([merchant_one, merchant_three])
  end
end
