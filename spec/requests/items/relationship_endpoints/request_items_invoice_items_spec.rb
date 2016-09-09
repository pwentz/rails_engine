require 'rails_helper'

RSpec.describe Api::V1::Items::InvoiceItemsController, type: :request do
  it 'returns collection of related items as json' do
    sample_item = create(:item)
    create_list(
      :invoice_item,
      2,
      item: sample_item
    )

    get "/api/v1/items/#{sample_item.id}/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(invoice_items.length).to eq(2)
    expect(
      invoice_items.first['item_id']
    ).to eq(sample_item.id)
  end
end
