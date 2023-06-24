class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table 'users', force: :cascade do |t|
      t.string 'username'
      t.timestamps
    end

    create_table 'vespas', force: :cascade do |t|
      t.string 'name'
      t.string 'icon'
      t.string 'description'
      t.float 'cost_per_day'
      t.timestamps
    end

    create_table 'reservations', force: :cascade do |t|
      t.belongs_to :user, index: true
      t.belongs_to :vespa, index: true
      t.date 'date'
      t.timestamps
    end

    add_foreign_key 'reservations', 'users', on_delete: :cascade
    add_foreign_key 'reservations', 'vespas', on_delete: :cascade
  end
end
