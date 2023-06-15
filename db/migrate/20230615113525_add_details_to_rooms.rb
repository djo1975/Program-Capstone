class AddDetailsToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :icon, :string
    add_column :rooms, :description, :string
    add_column :rooms, :cost_per_day, :float

    unless column_exists?(:reservations, :room_id)
      add_reference :reservations, :room, foreign_key: true, on_delete: :cascade
    else
      remove_foreign_key :reservations, :rooms
      add_foreign_key :reservations, :rooms, on_delete: :cascade
    end
  end
end
