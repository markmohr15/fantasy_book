class DeleteVarietyFromProp < ActiveRecord::Migration
  def change
    remove_column :props, :variety
  end
end
