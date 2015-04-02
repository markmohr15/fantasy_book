class AddBonusExpirationDateAndBonusCodeLength < ActiveRecord::Migration
  def change
    add_column :bonuses, :exp_date, :date
    add_column :bonus_codes, :length, :integer
  end
end
