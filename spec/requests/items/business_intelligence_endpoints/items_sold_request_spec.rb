require 'rails_helper'
include ItemsSampleDataHelper

RSpec.describe Api::V1::Items::ItemsSoldController, type: :request do
  it 'returns top x number of items in order of total number sold' do
    top_item_as_json = top_items_sample_data
    included_item = top_item_as_json[:item]
    excluded_item = Item.where.not(id: included_item.id)

    get '/api/v1/items/most_items?quantity=1'

    top_items_by_quantity = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(
      excluded_item
    ).not_to be_in(top_items_by_quantity)
  end
end
