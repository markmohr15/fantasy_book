class AddNameAddressAndUsernametoUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :address, :string
    add_column :users, :phone, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :country, :string
    add_column :users, :zip, :string
    add_column :users, :role, :integer, default: 1
    add_column :users, :name, :string
  end
end
