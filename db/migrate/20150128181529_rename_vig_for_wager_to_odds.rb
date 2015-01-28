class RenameVigForWagerToOdds < ActiveRecord::Migration
  def change
    rename_column :wagers, :vig, :odds
    rename_column :wagers, :pick, :prop_choice_id
  end
end
