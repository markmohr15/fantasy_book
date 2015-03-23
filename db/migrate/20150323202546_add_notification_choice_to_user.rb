class AddNotificationChoiceToUser < ActiveRecord::Migration
  def change
    add_column :users, :email_notif, :boolean, default: true
    add_column :users, :sms_notif, :boolean, default: false
  end
end
