class ChangePicturesColumnFromNameToPicture < ActiveRecord::Migration[5.1]
  def change
    rename_column :pictures, :name, :picture
  end
end
