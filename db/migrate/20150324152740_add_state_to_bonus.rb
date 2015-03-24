class AddStateToBonus < ActiveRecord::Migration
  def change
    add_column :bonuses, :state, :integer
  end
end
