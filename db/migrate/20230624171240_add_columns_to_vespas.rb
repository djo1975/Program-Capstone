class AddColumnsToVespas < ActiveRecord::Migration[7.0]
  def change
    add_column :vespas, :icon, :string
    add_column :vespas, :description, :text
    add_column :vespas, :cost_per_day, :decimal
  end
end
