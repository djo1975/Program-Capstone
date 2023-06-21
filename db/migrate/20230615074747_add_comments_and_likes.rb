class AddCommentsAndLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vespa, null: false, foreign_key: { on_delete: :cascade }
      t.text :content
      t.timestamps null: false
    end

    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true
      t.timestamps null: false
    end
  end
end
