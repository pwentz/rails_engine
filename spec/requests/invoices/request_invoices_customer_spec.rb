require 'rails_helper'

RSpec.describe Api::V1::Invoices::CustomersController, type: :request do
  it 'returns related customer as json' do
    sample_invoice = create(:invoice)

    get "/api/v1/invoices/#{sample_invoice.id}/customer"

    customer = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(customer).to have_key('id')
    expect(customer).to have_key('first_name')
    expect(customer).to have_key('last_name')
    expect(customer['id']).to eq(sample_invoice.customer_id)
  end
end
