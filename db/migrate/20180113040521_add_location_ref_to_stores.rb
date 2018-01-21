class AddLocationRefToStores < ActiveRecord::Migration[5.1]
  def change
    add_reference :stores, :location, foreign_key: true
  end
end
