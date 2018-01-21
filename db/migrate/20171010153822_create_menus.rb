class CreateMenus < ActiveRecord::Migration[5.1]
  def change
    create_table :menus do |t|
      t.string :name
      t.string :intro
      t.integer :price
      t.references :store, foreign_key: true, index: true

      t.timestamps
    end
  end
end
