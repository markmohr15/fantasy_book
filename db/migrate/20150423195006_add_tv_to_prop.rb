class AddTvToProp < ActiveRecord::Migration
  def change
    add_column :props, :tv, :string, default: ""
  end
end
