class AddStripeIdToDepositAndStripeCustIdToUser < ActiveRecord::Migration
  def change
    add_column :deposits, :stripe_id, :string
    add_column :users, :stripe_customer_id, :string
  end
end
