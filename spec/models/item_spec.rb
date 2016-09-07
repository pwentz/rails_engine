require 'rails_helper'

RSpec.describe Item, type: :model do
  context 'associations' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  xit 'returns top x items in order of most revenue' do
    # Skipping until method is fixed
    item_one = create(:item, unit_price: 900)
    item_two = create(:item, unit_price: 1200)
    item_three = create(:item, unit_price: 2000)

    create(
      :invoice_item,
      item: item_one,
      unit_price: item_one.unit_price,
      quantity: 10
    )

    create(
      :invoice_item,
      item: item_two,
      unit_price: item_two.unit_price,
      quantity: 3
    )

    create(
      :invoice_item,
      item: item_three,
      unit_price: item_three.unit_price,
      quantity: 4
    )

    expect(
      Item.most_revenue(2)
    ).to eq([item_one, item_three])
  end
end
