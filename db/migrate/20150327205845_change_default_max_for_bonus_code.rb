class ChangeDefaultMaxForBonusCode < ActiveRecord::Migration
  def change
    change_column :bonus_codes, :maximum, :integer, default: 20000
  end
end
