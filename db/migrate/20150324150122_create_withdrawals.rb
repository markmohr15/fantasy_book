class CreateWithdrawals < ActiveRecord::Migration
  def change
    create_table :withdrawals do |t|
      t.integer :user_id
      t.integer :amount
      t.string :method

      t.timestamps null: false
    end
  end
end
