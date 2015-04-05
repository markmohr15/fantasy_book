class AddSendTimeToMassEmail < ActiveRecord::Migration
  def change
    add_column :mass_emails, :send_at, :datetime
  end
end
