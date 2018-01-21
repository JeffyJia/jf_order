class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :store, foreign_key: true
      t.string :state
      t.text :menus
      t.datetime :paid_at
      t.datetime :confirmed_at
      t.datetime :refunded_at

      t.timestamps
    end
  end
end
