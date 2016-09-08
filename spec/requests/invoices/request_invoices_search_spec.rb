require 'rails_helper'

RSpec.describe Api::V1::Invoices::SearchController, type: :request do
  it 'returns a single instance matching params as json' do
    invoice_one = create(
      :invoice,
      status: 'shipped'
    )
    invoice_two = create(
      :invoice,
      status: 'not shipped'
    )

    get "/api/v1/invoices/find?status=#{invoice_one.status}"

    invoice = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(
      invoice['id']
    ).to eq(invoice_one.id)
  end

  it 'returns a collection of instances matching params as json' do
    invoice_one = create(
      :invoice,
      status: 'not shipped'
    )
    create_list(
      :invoice,
      2,
      status: 'shipped'
    )

    get "/api/v1/invoices/find_all?status=shipped"

    invoices = JSON.parse(response.body)
    invoice_one = invoice_one.to_json

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(invoices.length).to eq(2)
    expect(invoice_one).not_to be_in(invoices)
  end
end
