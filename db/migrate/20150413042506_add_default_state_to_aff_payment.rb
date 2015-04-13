class AddDefaultStateToAffPayment < ActiveRecord::Migration
  def change
    change_column :affiliate_payments, :state, :integer, default: 0
  end
end
