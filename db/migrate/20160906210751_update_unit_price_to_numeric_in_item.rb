class UpdateUnitPriceToNumericInItem < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :unit_price, :numeric, precision: 5, scale: 2
  end
end
