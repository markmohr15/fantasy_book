class AddEnabledAndOneTimeToBonusCodeModel < ActiveRecord::Migration
  def change
    add_column :bonus_codes, :enabled, :boolean, default: true
    add_column :bonus_codes, :one_time, :boolean, default: true
  end
end
