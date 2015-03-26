class RemoveKindFromBonus < ActiveRecord::Migration
  def change
    remove_column :bonuses, :kind
  end
end
