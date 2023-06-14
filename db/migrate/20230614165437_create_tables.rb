class CreateTables < ActiveRecord::Migration[7.0]
    def change
      create_table "users", force: :cascade do |t|
        t.string "username"
        t.timestamps
      end
  
      create_table "rooms", force: :cascade do |t|
        t.string "name"
        t.timestamps
      end
  
      create_table "reservations", force: :cascade do |t|
        t.belongs_to :user, index: true
        t.belongs_to :room, index: true
        t.date "date"
        t.timestamps
      end
  
      add_foreign_key "reservations", "users"
      add_foreign_key "reservations", "rooms"
    end
  end
  
