class AddTimestampToInvoiceItem < ActiveRecord::Migration[5.0]
  def change
    add_column :invoice_items, :created_at, :datetime
    add_column :invoice_items, :updated_at, :datetime
  end
end
