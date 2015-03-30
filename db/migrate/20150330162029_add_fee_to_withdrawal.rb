class AddFeeToWithdrawal < ActiveRecord::Migration
  def change
    add_column :withdrawals, :fee, :integer
  end
end
