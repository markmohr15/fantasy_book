class AddBetTypeToProp < ActiveRecord::Migration
  def change
    add_column :props, :type, :string
  end
end
