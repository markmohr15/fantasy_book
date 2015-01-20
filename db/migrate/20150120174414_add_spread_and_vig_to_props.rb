class AddSpreadAndVigToProps < ActiveRecord::Migration
  def change
    add_column :props, :home_spread, :float
    add_column :props, :home_vig, :integer
    add_column :props, :away_vig, :integer
    add_column :props, :winner, :integer
  end
end
