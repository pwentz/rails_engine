require 'rails_helper'

RSpec.describe "Request transactions", type: :request do
  it 'gets an individual transaction' do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(transaction).to have_key('id')
    expect(transaction).to have_key('invoice_id')
    expect(transaction).to have_key('credit_card_number')
    expect(transaction).to have_key('created_at')
    expect(transaction).to have_key('updated_at')
    expect(transaction).to_not have_key('credit_card_expiration_date')
  end

  it 'gets all transactions' do
    create_list(:transaction, 2)

    get '/api/v1/transactions'

    transactions = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(transactions.length).to eq(2)
  end

  it 'gets a random transaction' do
    create_list(:transaction, 3)

    get '/api/v1/transactions/random'

    transactions = Transaction.all.map(&:to_json)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(response.body).to be_in(transactions)
  end
end
