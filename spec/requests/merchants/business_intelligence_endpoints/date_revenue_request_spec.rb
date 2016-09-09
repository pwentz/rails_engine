require 'rails_helper'
include MerchantRevenueSampleDataHelper

RSpec.describe Api::V1::Merchants::DateRevenueController, type: :request do
  it 'returns the total revenue across all merchants on given date' do
    merchant_revenue(
      year: 2016,
      month: 8,
      day: [22, 28]
    )
    merchant_revenue(
      year: 2016,
      month: 8,
      day: [22, 28]
    )

    get '/api/v1/merchants/revenue', params: { date: '08/22/2016' }

    revenue_hash = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(
      revenue_hash['total_revenue']
    ).to eq('20.00')
  end
end
