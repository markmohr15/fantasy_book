class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :sport_id
      t.string :name
      t.string :team
      t.string :position

      t.timestamps null: false
    end
  end
end
