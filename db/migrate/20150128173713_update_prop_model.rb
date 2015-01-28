class UpdatePropModel < ActiveRecord::Migration
  def change
    remove_column :props, :player1_id
    remove_column :props, :player2_id
    remove_column :props, :player3_id
    remove_column :props, :player4_id
    remove_column :props, :home_spread
    remove_column :props, :away_vig
    remove_column :props, :home_vig
    remove_column :props, :away_score
    remove_column :props, :home_score
  end
end
