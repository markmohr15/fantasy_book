class RemoveOverUnderandResultFromProp < ActiveRecord::Migration
  def change
    remove_column :props, :over_under
    remove_column :props, :result
    remove_column :props, :maximum
  end
end
