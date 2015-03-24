class RenameBonusTypetoKind < ActiveRecord::Migration
  def change
    rename_column :bonuses, :type, :kind
  end
end
