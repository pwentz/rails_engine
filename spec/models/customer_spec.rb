require 'rails_helper'
include CustomersSampleDataHelper

RSpec.describe Customer, type: :model do
  context 'associations' do
    it { should have_many(:invoices) }
    it { should have_many(:merchants).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  context 'instance methods' do
    it "knows it's favorite merchant" do
      data = favorite_merchant_sample_data

      expect(data[:customer].favorite_merchant).to eq(data[:merchant_1])
    end
  end
end
