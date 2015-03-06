class RemovePropChoiceWinnerAndScore < ActiveRecord::Migration
  def change
    remove_column :prop_choices, :winner
    remove_column :prop_choices, :score
  end
end
