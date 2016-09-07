require 'rails_helper'

RSpec.describe 'Request customers', type: :request do
  it 'gets an individual customer' do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(customer).to have_key('id')
    expect(customer).to have_key('first_name')
    expect(customer).to have_key('last_name')
    expect(customer).to have_key('created_at')
    expect(customer).to have_key('updated_at')
  end

  it 'gets all customers' do
    create_list(:customer, 2)

    get '/api/v1/customers'

    customers = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(customers.length).to eq(2)
  end

  it 'gets a random customer' do
    create_list(:customer, 3)

    get '/api/v1/customers/random'

    customers = Customer.all.map(&:to_json)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(response.body).to be_in(customers)
  end
end
