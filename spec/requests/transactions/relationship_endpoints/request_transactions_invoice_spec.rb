require 'rails_helper'

RSpec.describe Api::V1::Transactions::InvoicesController, type: :request do
  it 'returns relates invoice as json' do
    sample_transaction = create(:transaction)

    get "/api/v1/transactions/#{sample_transaction.id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(invoice).to have_key('id')
    expect(invoice).to have_key('customer_id')
    expect(
      invoice['id']
    ).to eq(sample_transaction.invoice_id)
  end
end
