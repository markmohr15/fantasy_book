class RenameTypeToVarietyForProp < ActiveRecord::Migration
  def change
    rename_column :props, :type, :variety
  end
end
