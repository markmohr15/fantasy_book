class RenameMethodForWithdrawal < ActiveRecord::Migration
  def change
    rename_column :withdrawals, :method, :kind
  end
end
