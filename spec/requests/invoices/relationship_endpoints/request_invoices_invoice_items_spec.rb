require 'rails_helper'

RSpec.describe Api::V1::Invoices::InvoiceItemsController, type: :request do
  it 'returns related invoice items as json' do
    sample_invoice = create(:invoice)
    create_list(
      :invoice_item,
      2,
      invoice: sample_invoice
    )

    get "/api/v1/invoices/#{sample_invoice.id}/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(invoice_items.length).to eq(2)
    expect(
      invoice_items.first['invoice_id']
    ).to eq(sample_invoice.id)
  end
end
