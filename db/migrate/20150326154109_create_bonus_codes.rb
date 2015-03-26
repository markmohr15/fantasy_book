class CreateBonusCodes < ActiveRecord::Migration
  def change
    create_table :bonus_codes do |t|
      t.string :code
      t.integer :percentage
      t.integer :rollover
      t.string :note

      t.timestamps null: false
    end
  end
end
