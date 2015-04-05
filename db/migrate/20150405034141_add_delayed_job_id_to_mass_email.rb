class AddDelayedJobIdToMassEmail < ActiveRecord::Migration
  def change
    add_column :mass_emails, :delayed_job_id, :integer
  end
end
