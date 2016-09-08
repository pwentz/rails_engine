require 'rails_helper'
include ApplicationHelper

RSpec.describe 'Application helper' do
  it 'converts an int to a string with 2 decimals' do
    raw_number = 198_99

    expect(to_price(raw_number)).to eq("198.99")
  end
end
