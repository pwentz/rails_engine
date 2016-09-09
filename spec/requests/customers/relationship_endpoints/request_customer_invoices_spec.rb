require 'rails_helper'

RSpec.describe "Request customer invoices" do
  it 'gets a customers invoices' do
    customer = create(:customer)
    create_list(:invoice, 2, customer: customer)

    get "/api/v1/customers/#{customer.id}/invoices"
    invoices = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(invoices.length).to eq(2)
  end
end
