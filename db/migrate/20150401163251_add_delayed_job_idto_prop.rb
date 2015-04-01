class AddDelayedJobIdtoProp < ActiveRecord::Migration
  def change
    add_column :props, :delayed_job_id, :integer
  end
end
