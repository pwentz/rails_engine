require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'associations' do
    it { should have_many(:invoices) }
    it { should have_many(:merchants).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  context 'instance methods' do
    it "knows it's favorite merchant" do
      customer = create(:customer)
      merch_one,
        merch_two = create_list(:merchant, 2)
      invoices_one = create_list(
        :invoice,
        2,
        customer: customer,
        merchant: merch_one
      )
      invoices_two = create_list(
        :invoice,
        2,
        customer: customer,
        merchant: merch_two
      )
      create(:transaction, invoice: invoices_one.first, result: 'failed')
      create(:transaction, invoice: invoices_one.last)
      create(:transaction, invoice: invoices_two.first)
      create(:transaction, invoice: invoices_two.last)

      expect(customer.favorite_merchant).to eq(merch_two)
    end
  end
end
