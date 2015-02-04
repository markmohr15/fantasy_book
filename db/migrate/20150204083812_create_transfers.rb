class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :amount
      t.integer :status

      t.timestamps null: false
    end
  end
end
