class RemoveBonuModel < ActiveRecord::Migration
  def change
    drop_table :bonus
  end
end
