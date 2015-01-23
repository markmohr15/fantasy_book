class AddScoresToProp < ActiveRecord::Migration
  def change
    add_column :props, :away_score, :float
    add_column :props, :home_score, :float
    remove_column :props, :winner
  end
end
