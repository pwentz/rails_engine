require 'rails_helper'

RSpec.describe Api::V1::Items::MerchantsController, type: :request do
  it 'returns related merchant as json' do
    sample_item = create(:item)

    get "/api/v1/items/#{sample_item.id}/merchant"

    merchant = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(merchant).to have_key('id')
    expect(merchant).to have_key('name')
    expect(
      merchant['id']
    ).to eq(sample_item.merchant_id)
  end
end
