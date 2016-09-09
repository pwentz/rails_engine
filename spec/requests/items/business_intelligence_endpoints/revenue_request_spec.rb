require 'rails_helper'
include MerchantRevenueSampleDataHelper
include ItemsSampleDataHelper

RSpec.describe Api::V1::Items::RevenueController, type: :request do
  it 'returns x sized collection of items in order of revenue' do
    lowest_revenue_item = top_three_items_by_revenue.last

    get '/api/v1/items/most_revenue?quantity=2'

    returned_items = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(
      lowest_revenue_item
    ).not_to be_in(returned_items)
  end
end
