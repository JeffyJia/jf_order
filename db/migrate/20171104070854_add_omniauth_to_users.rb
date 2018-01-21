class AddOmniauthToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string

    add_column :users, :nickname, :string
    add_column :users, :sex, :integer
    add_column :users, :avatar, :string
  end
end
