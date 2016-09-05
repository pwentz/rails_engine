class AddTimestampToMerchant < ActiveRecord::Migration[5.0]
  def change
    add_column :merchants, :created_at, :datetime
    add_column :merchants, :updated_at, :datetime
  end
end
