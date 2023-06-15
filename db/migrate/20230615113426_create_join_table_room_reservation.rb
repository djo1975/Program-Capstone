class CreateJoinTableRoomReservation < ActiveRecord::Migration[7.0]
  def change
    create_join_table :rooms, :reservations, table_name: :room_reservations do |t|
      t.index %i[room_id reservation_id]
      t.index %i[reservation_id room_id]
    end
  end
end
