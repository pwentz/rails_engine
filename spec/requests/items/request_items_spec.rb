require 'rails_helper'
include SampleDataHelper

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

  it 'gets the best day of an item' do
    data = best_day_sample_data

    get "/api/v1/items/#{data[:item].id}/best_day"

    body = JSON.parse(response.body)
    formatted_day = data[:day].split(' ').join('T')
    expected = { "best_day" => "#{formatted_day}.000Z" }

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(body).to eq(expected)
  end

  it 'gets top items by number sold' do
    data = top_items_sample_data

    get '/api/v1/items/most_items?quantity=1'

    body = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(body.length).to eq(1)
    expect(body.first['id']).to eq(data[:item].id)
  end
end
