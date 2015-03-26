class AddReferralCodeToUser < ActiveRecord::Migration
  def change
    add_column :users, :referral_code, :string
  end
end
