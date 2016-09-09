require 'rails_helper'

RSpec.describe Api::V1::Merchants::ItemsController, type: :request do
  it 'returns a collection of related items as json' do
    sample_merchant = create(:merchant)
    create_list(
      :item,
      2,
      merchant: sample_merchant
    )

    get "/api/v1/merchants/#{sample_merchant.id}/items"

    items = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(items.length).to eq(2)
    expect(
      items.first['merchant_id']
    ).to eq(sample_merchant.id)
  end
end
