class RenameDepositMethodToKind < ActiveRecord::Migration
  def change
    rename_column :deposits, :method, :kind
  end
end
