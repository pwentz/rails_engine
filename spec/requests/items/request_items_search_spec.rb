require 'rails_helper'

RSpec.describe Api::V1::Items::SearchController, type: :request do
  it 'returns a single item instance matching params as json' do
    item_one = create(
      :item,
      unit_price: 100
    )
    item_two = create(
      :item,
      unit_price: 80
    )

    get "/api/v1/items/find?unit_price=#{item_one.unit_price}"

    item = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(
      item['id']
    ).to eq(item_one.id)
  end

  it 'returns a collection of instances matching params as json' do
    item_one = create(
      :item,
      unit_price: 500
    )
    list_items = create_list(
      :item,
      2,
      unit_price: 300
    )

    get "/api/v1/items/find_all", params: { unit_price: '3.0' }

    items = JSON.parse(response.body)
    item_one = item_one.to_json

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(items.length).to eq(2)
    expect(item_one).not_to be_in(items)
  end
end
