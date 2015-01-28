class AddWinnerToPropChoice < ActiveRecord::Migration
  def change
    add_column :prop_choices, :winner, :boolean, default: false
  end
end
