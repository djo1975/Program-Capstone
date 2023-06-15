class RemoveRoomIdFromReservations < ActiveRecord::Migration[7.0]
  def change
    remove_column :reservations, :room_id, :bigint
  end
end
