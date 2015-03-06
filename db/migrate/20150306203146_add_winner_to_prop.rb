class AddWinnerToProp < ActiveRecord::Migration
  def change
    add_column :props, :winner, :integer
  end
end
