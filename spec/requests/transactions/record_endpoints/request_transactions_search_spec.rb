require 'rails_helper'

RSpec.describe Api::V1::Transactions::SearchController, type: :request do
  it 'returns a single transaction instance matching params as json' do
    trans_one = create(
      :transaction,
      result: 'failure'
    )
    trans_two = create(
      :transaction,
      result: 'success'
    )

    get "/api/v1/transactions/find?result=#{trans_one.result}"

    transaction = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(
      transaction['id']
    ).to eq(trans_one.id)
  end

  it 'returns a collection of instances matching params as json' do
    trans_one = create(
      :transaction,
      result: 'failure'
    )
    create_list(
      :transaction,
      2,
      result: 'success'
    )

    get '/api/v1/transactions/find_all?result=success'

    transactions = JSON.parse(response.body)
    trans_one = trans_one.to_json

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(transactions.length).to eq(2)
    expect(trans_one).not_to be_in(transactions)
  end
end
