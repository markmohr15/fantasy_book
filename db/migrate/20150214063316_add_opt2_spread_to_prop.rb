class AddOpt2SpreadToProp < ActiveRecord::Migration
  def change
    add_column :props, :opt2_spread, :float
  end
end
