ActiveAdmin.register MassEmail do
  filter :group
  filter :created_at
  menu priority: 16

  index do
    selectable_column
    column :subject
    column :group
    column "Send At" do |me|
      me.send_at.try(:strftime,'%Y-%m-%d %I:%M %p')
    end
    column "Created At" do |me|
      me.created_at.try(:strftime,'%Y-%m-%d %I:%M %p')
    end
    actions
  end

  show do
    attributes_table do
      row :subject
      row :message
      row :group
      row "Send At" do |me|
        me.send_at.try(:strftime,'%Y-%m-%d %I:%M %p')
      end
      row "Created At" do |me|
        me.created_at.try(:strftime,'%Y-%m-%d %I:%M %p')
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Mass Email Details" do
      f.input :subject, required: true
      f.input :message, required: true
      f.input :group, as: :radio, collection: ["Players_And_VIP", "Players", "VIP", "AllAdmins"], blank: false, required: true
      f.input :send_at, as: :just_datetime_picker, required: true
    end
    actions
  end

  permit_params :subject, :message, :group, :send_at_date,
  :send_at_time_hour, :send_at_time_minute
end
