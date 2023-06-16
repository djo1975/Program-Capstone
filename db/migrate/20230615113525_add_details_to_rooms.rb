class AddDetailsToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :icon, :string
    add_column :rooms, :description, :string
    add_column :rooms, :cost_per_day, :float
  end
end
