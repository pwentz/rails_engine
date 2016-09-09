require 'rails_helper'
include MerchantsSampleDataHelper

RSpec.describe Api::V1::Merchants::CustomersController, type: :request do
  it 'returns collection of merchant instance customers w/ pending invoices' do
    customers_with_pending_invoices
    merchant = Merchant.first
    excluded_customer = pending_invoice_customer(merchant)

    get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

    returned_customers = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(
      excluded_customer
    ).not_to be_in(returned_customers)
  end

  it 'returns favorite customer of merchant instance' do
    included_customer = favorite_customer_sample_data
    merchant = Merchant.first

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    returned_customer = response.body

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(
      included_customer.to_json
    ).to eq(returned_customer)
  end
end
