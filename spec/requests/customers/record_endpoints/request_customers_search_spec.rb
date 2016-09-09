require 'rails_helper'

RSpec.describe 'Request customers search', type: :request do
  it 'returns a single instance matching params as json' do
    customer_one = create(
      :customer,
      first_name: 'Freds'
    )
    customer_two = create(
      :customer,
      first_name: 'Bills'
    )

    get "/api/v1/customers/find?first_name=#{customer_one.first_name}"

    customer = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(
      customer['id']
    ).to eq(customer_one.id)
  end

  it 'returns a collection of instances matching params as json' do
    customer_one = create(
      :customer,
      last_name: 'James'
    )
    customer_two = create(
      :customer,
      last_name: 'Harris'
    )

    get "/api/v1/customers/find_all?last_name=#{customer_two.last_name}"

    customers = JSON.parse(response.body)
    customer_two = customer_two.to_json

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(customers.length).to eq(1)
    expect(customer_two).not_to be_in(customers)
  end
end
