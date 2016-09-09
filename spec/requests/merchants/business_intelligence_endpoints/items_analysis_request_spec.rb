require 'rails_helper'
include MerchantRevenueSampleDataHelper
include MerchantsSampleDataHelper

RSpec.describe Api::V1::Merchants::ItemsAnalysisController, type: :request do
  it 'returns x sized collection of merchants in order of items sold' do
    top_three_merchants = top_three_merchants_by_items_sold
    excluded_merchant = top_three_merchants.last

    get '/api/v1/merchants/most_items', params: { quantity: 2 }

    returned_merchants = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(returned_merchants.length).to eq(2)
    expect(
      excluded_merchant
    ).not_to be_in(returned_merchants)
  end
end
