class AddMaximumToProp < ActiveRecord::Migration
  def change
    add_column :props, :maximum, :integer
  end
end
