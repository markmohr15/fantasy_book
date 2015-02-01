ActiveAdmin.register User do
  actions :all, except: [:new, :create]
  filter :email
  menu priority: 3

  index do
    selectable_column
    column :email
    column :name
    column :username
    column :phone
    column "Balance", :balance_dollars
    actions
  end

  show do
    attributes_table do
      row :email
      row :name
      row :username
      row "Balance" do
        user.balance_dollars
      end
      row :address
      row :city
      row :state
      row :zip
      row :country
      row :phone
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :name
      f.input :username
      f.input :balance_dollars, label: "Balance"
      f.input :address
      f.input :city
      f.input :state, as: :select, collection: (us_states)
      f.input :zip
      f.input :country, as: :select, collection: ["USA", "Canada", "Mexico"]
      f.input :phone
    end
    f.actions
  end

  permit_params :email, :name, :username, :balance_dollars, :address, :city, :state, :zip, :country, :phone

  controller do
    def scoped_collection
      User.where(role: 1)
    end
  end


end
