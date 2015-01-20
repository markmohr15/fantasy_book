class AddStateToProp < ActiveRecord::Migration
  def change
    add_column :props, :state, :integer, default: 0
  end
end
