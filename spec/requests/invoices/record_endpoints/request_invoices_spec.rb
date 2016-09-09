require 'rails_helper'

RSpec.describe "Request invoices", type: :request do
  it 'gets an individual invoice' do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(invoice).to have_key('id')
    expect(invoice).to have_key('customer_id')
    expect(invoice).to have_key('merchant_id')
    expect(invoice).to have_key('status')
    expect(invoice).to have_key('created_at')
    expect(invoice).to have_key('updated_at')
  end

  it 'gets all invoices' do
    create_list(:invoice_item, 2)

    get '/api/v1/invoices'

    invoices = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(invoices.length).to eq(2)
  end

  it 'gets a random invoice' do
    create_list(:invoice, 3)

    get '/api/v1/invoices/random'

    invoices = Invoice.all.map(&:to_json)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(response.body).to be_in(invoices)
  end
end
