class CreateWagers < ActiveRecord::Migration
  def change
    create_table :wagers do |t|
      t.integer :prop_id
      t.integer :user_id
      t.integer :state, default: 0
      t.integer :risk
      t.integer :win
      t.integer :pick
      t.integer :vig

      t.timestamps null: false
    end
  end
end
