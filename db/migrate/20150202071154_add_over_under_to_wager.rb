class AddOverUnderToWager < ActiveRecord::Migration
  def change
    add_column :wagers, :total, :float
  end
end
