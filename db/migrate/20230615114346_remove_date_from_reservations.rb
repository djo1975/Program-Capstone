class RemoveDateFromReservations < ActiveRecord::Migration[7.0]
  def change
    remove_column :reservations, :date, :date
  end
end
