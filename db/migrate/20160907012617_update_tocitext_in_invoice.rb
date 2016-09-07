class UpdateTocitextInInvoice < ActiveRecord::Migration[5.0]
  def change
    change_column :invoices, :status, :citext
  end
end
