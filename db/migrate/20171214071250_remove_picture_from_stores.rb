class RemovePictureFromStores < ActiveRecord::Migration[5.1]
  def change
    remove_column :stores, :picture, :string
  end
end
