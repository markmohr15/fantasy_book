ActiveAdmin.register Sport do
  config.filters = false
  menu priority: 2

  index do
    selectable_column
    column :name
    actions
  end

  show do
    attributes_table do
      row :name
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Sport" do
      f.input :name
    end
    f.actions
  end

  permit_params :name

end
