class AddAffiliateToUser < ActiveRecord::Migration
  def change
    add_column :users, :affiliate, :boolean, default: false
  end
end
