class RemoveTotalFromWager < ActiveRecord::Migration
  def change
    remove_column :wagers, :total
  end
end
