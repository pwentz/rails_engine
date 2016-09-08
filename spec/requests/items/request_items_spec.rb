require 'rails_helper'

RSpec.describe "Request items", type: :request do
  it 'gets an individual item' do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(item).to have_key('id')
    expect(item).to have_key('name')
    expect(item).to have_key('description')
    expect(item).to have_key('unit_price')
    expect(item).to have_key('merchant_id')
    expect(item).to have_key('created_at')
    expect(item).to have_key('updated_at')
  end

  it 'gets all items' do
    create_list(:item, 2)

    get '/api/v1/items'

    items = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(items.length).to eq(2)
  end

  it 'gets a random item' do
    create_list(:item, 3)

    get '/api/v1/items/random'

    items = Item.pluck(:id)
    body = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(body['id']).to be_in(items)
  end
end
