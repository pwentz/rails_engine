require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'associations' do
    it { should have_many(:invoices) }
    it { should have_many(:merchants).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end
end
