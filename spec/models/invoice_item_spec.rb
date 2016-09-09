require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  context 'associations' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end
end
