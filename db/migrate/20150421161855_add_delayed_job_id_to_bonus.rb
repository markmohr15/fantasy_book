class AddDelayedJobIdToBonus < ActiveRecord::Migration
  def change
    add_column :bonuses, :delayed_job_id, :integer
  end
end
