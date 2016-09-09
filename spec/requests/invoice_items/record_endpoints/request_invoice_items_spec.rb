require 'rails_helper'

RSpec.describe "Request invoice items", type: :request do
  it 'gets an individual invoice item record' do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(invoice_item).to have_key('id')
    expect(invoice_item).to have_key('item_id')
    expect(invoice_item).to have_key('invoice_id')
    expect(invoice_item).to have_key('quantity')
    expect(invoice_item).to have_key('created_at')
    expect(invoice_item).to have_key('updated_at')
  end

  it 'gets all invoice item records' do
    create_list(:invoice_item, 2)

    get '/api/v1/invoice_items'

    invoice_items = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(invoice_items.length).to eq(2)
  end

  it 'gets a random invoice_item_record' do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items/random'

    invoice_items = InvoiceItem.pluck(:id)
    body = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(body['id']).to be_in(invoice_items)
  end
end
