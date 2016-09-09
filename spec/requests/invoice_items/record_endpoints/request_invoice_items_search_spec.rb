require 'rails_helper'

RSpec.describe Api::V1::InvoiceItems::SearchController, type: :request do
  it 'returns a single instance matching params as json' do
    invoice_item_one = create(
      :invoice_item,
      unit_price: 100
    )
    invoice_item_two = create(
      :invoice_item,
      unit_price: 80
    )

    get "/api/v1/invoice_items/find?unit_price=#{invoice_item_one.unit_price}"

    invoice_item = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(
      invoice_item['id']
    ).to eq(invoice_item_one.id)
  end

  it 'returns a collection of instances matching params as json' do
    invoice_item_one = create(
      :invoice_item,
      unit_price: 500
    )
    list_items = create_list(
      :invoice_item,
      2,
      unit_price: 300
    )

    get "/api/v1/invoice_items/find_all", params: { unit_price: '3.0' }

    invoice_items = JSON.parse(response.body)
    invoice_item_one = invoice_item_one.to_json

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(invoice_items.length).to eq(2)
    expect(invoice_item_one).not_to be_in(invoice_items)
  end
end
