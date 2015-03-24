class CreateBonus < ActiveRecord::Migration
  def change
    create_table :bonus do |t|
      t.integer :user_id
      t.integer :amount
      t.integer :pending
      t.string :type

      t.timestamps null: false
    end
  end
end
