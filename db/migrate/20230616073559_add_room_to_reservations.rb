class AddRoomToReservations < ActiveRecord::Migration[7.0]
  def change
    add_reference :reservations, :room, foreign_key: true
  end
end
