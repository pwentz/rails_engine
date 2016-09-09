require 'rails_helper'
include MerchantRevenueSampleDataHelper

RSpec.describe Api::V1::Merchants::RevenueController, type: :request do
  it 'returns the revenue for an individual merchant w/o date' do
    merchant_revenue
    merchant = Merchant.first

    get "/api/v1/merchants/#{merchant.id}/revenue"

    returned_revenue = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(
      returned_revenue['revenue']
    ).to eq('20.00')
  end

  it 'returns the revenue for an individual merchant w/ date' do
    merchant_revenue(
      year: 2016,
      month: 8,
      day: [22, 28]
    )
    merchant = Merchant.first

    get "/api/v1/merchants/#{merchant.id}/revenue", params: { date: '08/22/16' }

    returned_revenue = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(
      returned_revenue['revenue']
    ).to eq('10.00')
  end
end
