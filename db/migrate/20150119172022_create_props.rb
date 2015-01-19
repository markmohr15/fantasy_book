class CreateProps < ActiveRecord::Migration
  def change
    create_table :props do |t|
      t.integer :sport_id
      t.integer :player1_id
      t.integer :player2_id
      t.integer :player3_id
      t.integer :player4_id
      t.datetime :time

      t.timestamps null: false
    end
  end
end
