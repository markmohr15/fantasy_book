class AddMaximumToBonusCode < ActiveRecord::Migration
  def change
    add_column :bonus_codes, :maximum, :integer, default: 1000000
  end
end
