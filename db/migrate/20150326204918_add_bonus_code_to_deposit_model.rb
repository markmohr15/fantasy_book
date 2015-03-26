class AddBonusCodeToDepositModel < ActiveRecord::Migration
  def change
    add_column :deposits, :bonus_code, :string
  end
end
