require 'rails_helper'

RSpec.describe Api::V1::InvoiceItems::ItemsController, type: :request do
  it 'returns associated item as json' do
    sample_invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/#{sample_invoice_item.id}/item"

    item = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(item).to have_key('name')
    expect(item).to have_key('description')
    expect(item).to have_key('unit_price')
    expect(item).to have_key('merchant_id')
  end
end
