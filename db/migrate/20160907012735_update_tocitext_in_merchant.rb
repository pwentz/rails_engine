class UpdateTocitextInMerchant < ActiveRecord::Migration[5.0]
  def change
    change_column :merchants, :name, :citext
  end
end
