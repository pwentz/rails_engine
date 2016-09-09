require 'rails_helper'

RSpec.describe "Request customers transactions", type: :request do
  it 'gets a customers transactions' do
    sample_customer = create(:customer)
    sample_invoice = create(
      :invoice,
      customer: sample_customer
    )
    create_list(
      :transaction,
      2,
      invoice: sample_invoice
    )

    get "/api/v1/customers/#{sample_customer.id}/transactions"
    transactions = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(transactions.length).to eq(2)
  end
end
