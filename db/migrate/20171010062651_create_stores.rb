class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :intro
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
