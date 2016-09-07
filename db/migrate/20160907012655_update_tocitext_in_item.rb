class UpdateTocitextInItem < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :name, :citext
    change_column :items, :description, :citext
  end
end
