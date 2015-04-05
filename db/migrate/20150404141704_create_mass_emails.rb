class CreateMassEmails < ActiveRecord::Migration
  def change
    create_table :mass_emails do |t|
      t.text :message
      t.string :subject
      t.integer :group

      t.timestamps null: false
    end
  end
end
