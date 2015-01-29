class AddPropositionToProp < ActiveRecord::Migration
  def change
    add_column :props, :proposition, :text
  end
end
