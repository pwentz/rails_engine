require 'rails_helper'
include ItemsSampleDataHelper

RSpec.describe Item, type: :model do
  context 'associations' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  context 'class methods' do
    it 'returns top x items in order of most revenue' do
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

      create(:transaction, invoice: item_one.invoices.first)
      create(:transaction, invoice: item_two.invoices.first)
      create(:transaction, invoice: item_three.invoices.first)

      expect(
        Item.most_revenue(2)
      ).to eq([item_one, item_three])
    end

    it 'returns top items by number sold' do
      data = top_items_sample_data

      expect(Item.top_items_by_number_sold(1)).to eq([data[:item]])
    end
  end

  context 'instance methods' do
    it "returns an item's best day" do
      data = best_day_sample_data

      expect(data[:item].best_day).to eq(data[:day])
    end
  end
end
