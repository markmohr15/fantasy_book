class AddAvailableToPropChoice < ActiveRecord::Migration
  def change
    add_column :prop_choices, :available, :integer, default: 0
  end
end
