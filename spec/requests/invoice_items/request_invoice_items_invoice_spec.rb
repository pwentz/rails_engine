require 'rails_helper'

RSpec.describe Api::V1::InvoiceItems::InvoicesController, type: :request do
  it 'returns related invoices in json format' do
    sample_invoice_item = create(
      :invoice_item,
    )

    get "/api/v1/invoice_items/#{sample_invoice_item.id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(invoice).to have_key('id')
    expect(invoice).to have_key('customer_id')
    expect(invoice).to have_key('merchant_id')
    expect(invoice).to have_key('status')
    expect(
      invoice['id']
    ).to eq(sample_invoice_item.invoice_id)
  end
end
