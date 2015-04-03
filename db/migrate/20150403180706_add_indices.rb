class AddIndices < ActiveRecord::Migration
  def change
    add_index :affiliate_payments, :affiliate_id
    add_index :affiliate_payments, :user_id
    add_index :bonuses, :user_id
    add_index :bonuses, :bonus_code_id
    add_index :credits, :admin_id
    add_index :credits, :user_id
    add_index :deposits, :user_id
    add_index :props, :user_id
    add_index :transfers, :sender_id
    add_index :transfers, :receiver_id
    add_index :wagers, :prop_choice_id
    add_index :withdrawals, :user_id
  end
end
