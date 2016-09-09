require 'rails_helper'
include CustomersSampleDataHelper

RSpec.describe "Request customer favorite merchant", type: :request do
  it "gets a customer's favorite merchant" do
    data = favorite_merchant_sample_data

    get "/api/v1/customers/#{data[:customer].id}/favorite_merchant"

    favorite_merchant = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(favorite_merchant['id']).to eq(data[:merchant_1].id)
  end
end
