class AddReleasedToBonus < ActiveRecord::Migration
  def change
    add_column :bonuses, :released, :integer, default: 0
  end
end
