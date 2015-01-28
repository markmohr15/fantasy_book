class CreatePropChoices < ActiveRecord::Migration
  def change
    create_table :prop_choices do |t|
      t.integer :prop_id
      t.text :choice
      t.integer :odds
      t.float :spread
      t.float :score

      t.timestamps null: false
    end
  end
end
