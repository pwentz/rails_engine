require 'rails_helper'

RSpec.describe "Request merchants", type: :request do
  it 'gets an individual merchant' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(merchant).to have_key('id')
    expect(merchant).to have_key('name')
    expect(merchant).to have_key('created_at')
    expect(merchant).to have_key('updated_at')
  end

  it 'gets all merchants' do
    create_list(:merchant, 2)

    get '/api/v1/merchants'

    merchants = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(merchants.length).to eq(2)
  end

  it 'gets a random merchant' do
    create_list(:merchant, 3)

    get '/api/v1/merchants/random'

    merchants = Merchant.all.map(&:to_json)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(response.body).to be_in(merchants)
  end
end
