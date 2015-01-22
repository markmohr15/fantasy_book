class AddSpreadToWager < ActiveRecord::Migration
  def change
    add_column :wagers, :spread, :float
  end
end
