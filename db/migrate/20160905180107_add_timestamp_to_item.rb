class AddTimestampToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :created_at, :datetime
    add_column :items, :updated_at, :datetime
  end
end
