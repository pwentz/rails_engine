require 'rails_helper'
include ItemsSampleDataHelper

RSpec.describe Api::V1::Items::DailySalesController, type: :request do
  it 'returns a date from item instances best day of sales' do
    best_day_sample_data
    item = Item.first

    get "/api/v1/items/#{item.id}/best_day"

    returned_json = JSON.parse(response.body)
    date_pool = item.invoices.pluck(:created_at)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(
      returned_json['best_day']
    ).to be_in(date_pool)
  end
end
