class AddActiveToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :active, :boolean, default: true
  end
end
