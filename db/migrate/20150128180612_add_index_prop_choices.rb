class AddIndexPropChoices < ActiveRecord::Migration
  def change
    add_index :prop_choices, :prop_id
  end
end
