class CreateAffiliatePayments < ActiveRecord::Migration
  def change
    create_table :affiliate_payments do |t|
      t.integer :amount
      t.integer :state
      t.integer :affiliate_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
