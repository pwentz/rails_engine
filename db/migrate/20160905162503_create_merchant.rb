class CreateMerchant < ActiveRecord::Migration[5.0]
  def change
    create_table :merchants do |t|
      t.text :name
    end
  end
end
