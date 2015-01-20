ActiveAdmin.register Player do

  filter :sport
  filter :name
  filter :position, as: :select
  filter :team, as: :select

  index do
    selectable_column
    column :sport
    column :name
    column :position
    column :team
    actions
  end

  show do
    attributes_table do
      row :sport
      row :name
      row :position
      row :team
    end
  end

  form do |f|
    f.inputs "Player Details" do
      f.input :sport
      f.input :name
      f.input :position
      f.input :team
    end
    f.actions
  end


  permit_params :name, :position, :team, :sport_id

end
