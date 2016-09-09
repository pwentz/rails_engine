require 'rails_helper'
include MerchantRevenueSampleDataHelper

RSpec.describe Api::V1::Merchants::MostRevenueController, type: :request do
  it 'returns an x sized collection of merchants ranked by top revenue' do
    top_three_merchants_by_revenue

    get '/api/v1/merchants/most_revenue?quantity=2'

    returned_merchants = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(
      top_three_merchants_by_revenue.last
    ).not_to be_in(returned_merchants)
  end
end
