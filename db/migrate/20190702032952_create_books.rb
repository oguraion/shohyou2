class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name, null: false, unique: true, limit: 50
      t.string :author, null: false, limit: 30
      t.integer :page
      t.text :image
      t.string :discription, limit: 1000
      t.references :genre, foreign_key: true
      t.timestamps
    end
  end
end
