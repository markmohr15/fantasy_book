ActiveAdmin.register Credit do
  filter :user, as: :select, collection: User.where("role = ? or role = ?", 1, 3).order("name")
  filter :admin, as: :select, collection: User.where("role = ? or role = ?", 0, 2).order("name")
  config.batch_actions = false
  actions :all, except: [:destroy, :edit]

  index do
    column "User" do |wager|
      link_to(wager.user.name, admin_user_path(wager.user.id))
    end
    column "Amount" do |credit|
      number_to_currency credit.amount_dollars
    end
    column :admin
    actions
  end

  show do
    attributes_table do
      row "User" do |wager|
        link_to(wager.user.name, admin_user_path(wager.user.id))
      end
      row "Amount" do
        number_to_currency credit.amount_dollars
      end
      row :note
      row :admin
      row :created_at
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Player Credit" do
      f.input :user, required: true, as: :select, collection: User.where("role = ? or role = ?", 1, 3).order('name')
      f.input :amount_dollars, required: true, label: "Amount"
      f.input :note
    end
    f.actions
  end

  before_create do |credit|
    credit.admin = current_user
  end

  permit_params :user_id, :amount_dollars, :note

end
