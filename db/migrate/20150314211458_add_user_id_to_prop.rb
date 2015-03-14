class AddUserIdToProp < ActiveRecord::Migration
  def change
    add_column :props, :user_id, :integer
  end
end
