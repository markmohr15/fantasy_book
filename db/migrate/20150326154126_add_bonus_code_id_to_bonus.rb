class AddBonusCodeIdToBonus < ActiveRecord::Migration
  def change
    add_column :bonuses, :bonus_code_id, :integer
  end
end
