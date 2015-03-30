class AddStateToWithdrawal < ActiveRecord::Migration
  def change
    add_column :withdrawals, :state, :integer, default: 0
  end
end
