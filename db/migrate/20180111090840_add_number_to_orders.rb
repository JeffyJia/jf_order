class AddNumberToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :number, :string, unique: true
  end
end
