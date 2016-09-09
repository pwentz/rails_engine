require 'rails_helper'

RSpec.describe Api::V1::Merchants::SearchController, type: :request do
  it 'returns a single merchant instance matching params as json' do
    merch_one = create(
      :merchant,
      name: 'Freds'
    )
    merch_two = create(
      :merchant,
      name: 'Bills'
    )

    get "/api/v1/merchants/find?name=#{merch_one.name}"

    merchant = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(
      merchant['id']
    ).to eq(merch_one.id)
  end

  it 'returns a collection of instances matching params as json' do
    merch_one = create(
      :merchant,
      name: 'Freds'
    )
    merch_two = create(
      :merchant,
      name: 'Bills'
    )

    get "/api/v1/merchants/find_all?name=#{merch_one.name}"

    merchants = JSON.parse(response.body)
    merch_two = merch_two.to_json

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(merchants.length).to eq(1)
    expect(merch_two).not_to be_in(merchants)
  end
end
