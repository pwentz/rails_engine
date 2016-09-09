require 'rails_helper'
include MerchantRevenueSampleDataHelper
include MerchantsSampleDataHelper

RSpec.describe Merchant, type: :model do
  context 'associations' do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  it 'returns the top ranked x merchants by total items sold' do
    merchants = top_three_merchants_by_items_sold
    excluded_merchant = merchants.last

    expect(
      Merchant.most_items_sold(2)
    ).to eq(merchants[0..1])

    expect(
      excluded_merchant
    ).not_to be_in(Merchant.most_items_sold(2))
  end

  it 'returns revenue across all merchants by date' do
    top_three_merchants_by_revenue(
      year: 2016,
      month: 8,
      day: [22, 28]
    )

    expect(
      Merchant.revenue_on_date("08/22/16")
    ).to eq(3900)
  end

  it 'returns revenue for individual merchant' do
    merchant_revenue

    expect(
      Merchant.first.revenue
    ).to eq(2000)
  end

  it 'returns revenue on date for an individual merchant' do
    merchant_revenue(
      year: 2016,
      month: 8,
      day: [22, 28]
    )

    expect(
      Merchant.first.revenue_on_date("08/22/2016")
    ).to eq(1000)
  end
end
