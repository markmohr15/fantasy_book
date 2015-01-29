class AddOverUnderAndSpreadToProp < ActiveRecord::Migration
  def change
    add_column :props, :over_under, :float
    add_column :props, :opt1_spread, :float
    add_column :props, :result, :float
    remove_column :prop_choices, :spread
  end
end
