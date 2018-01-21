class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :phone_number
      t.string :info
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
