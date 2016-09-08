require 'rails_helper'

RSpec.describe Api::V1::Invoices::ItemsController, type: :request do
  it 'returns related items as json' do
    sample_invoice = create(:invoice)
    create_list(
      :invoice_item,
      2,
      invoice: sample_invoice
    )

    get "/api/v1/invoices/#{sample_invoice.id}/items"

    items = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(items.length).to eq(2)
    expect(response.content_type).to eq('application/json')
  end
end
