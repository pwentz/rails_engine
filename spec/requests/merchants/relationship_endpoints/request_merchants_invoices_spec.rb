require 'rails_helper'

RSpec.describe Api::V1::Merchants::InvoicesController, type: :request do
  it 'returns a collection of related invoices as json' do
    sample_merchant = create(:merchant)
    create_list(
      :invoice,
      2,
      merchant: sample_merchant
    )

    get "/api/v1/merchants/#{sample_merchant.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(invoices.length).to eq(2)
    expect(
      invoices.first['merchant_id']
    ).to eq(sample_merchant.id)
  end
end
