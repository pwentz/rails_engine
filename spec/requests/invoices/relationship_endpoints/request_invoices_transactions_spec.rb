require 'rails_helper'

RSpec.describe Api::V1::Invoices::TransactionsController, type: :request do
  it 'returns related transactions as json' do
    sample_invoice = create(:invoice)
    create_list(
      :transaction,
      2,
      invoice: sample_invoice
    )

    get "/api/v1/invoices/#{sample_invoice.id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(transactions.length).to eq(2)
    expect(response.content_type).to eq('application/json')
    expect(
      transactions.first['invoice_id']
    ).to eq(sample_invoice.id)
  end
end
