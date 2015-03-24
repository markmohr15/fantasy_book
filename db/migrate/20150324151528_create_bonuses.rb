class CreateBonuses < ActiveRecord::Migration
  def change
    create_table :bonuses do |t|
      t.integer :user_id
      t.integer :amount
      t.integer :pending
      t.string :type
      t.integer :rollover

      t.timestamps null: false
    end
  end
end
