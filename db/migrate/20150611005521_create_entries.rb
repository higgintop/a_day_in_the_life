class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.text :post
      t.string :user
      t.references :user, index: true, foreign_key: true
      t.references :journal, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
