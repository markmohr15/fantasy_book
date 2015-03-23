class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :admin_id
      t.integer :amount
      t.string :note

      t.timestamps null: false
    end
  end
end
