class AddIndexes < ActiveRecord::Migration
  def change
    add_index :wagers, :prop_id
    add_index :wagers, :user_id
    add_index :players, :sport_id
    add_index :props, :sport_id
    add_index :props, :player1_id
    add_index :props, :player2_id
    add_index :props, :player3_id
    add_index :props, :player4_id
  end
end
