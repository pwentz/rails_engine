require 'rails_helper'

RSpec.describe Api::V1::Invoices::MerchantsController, type: :request do
  it 'returns related merchant as json' do
    sample_invoice = create(:invoice)

    get "/api/v1/invoices/#{sample_invoice.id}/merchant"

    merchant = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(merchant).to have_key('id')
    expect(merchant).to have_key('name')
    expect(merchant['id']).to eq(sample_invoice.merchant_id)
  end
end
