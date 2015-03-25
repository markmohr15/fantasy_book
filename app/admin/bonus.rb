ActiveAdmin.register Bonus do
  filter :user, as: :select, collection: User.where("role = ? or role = ?", 1, 3).order("name")
  filter :kind, as: :select, collection: ["Initial Deposit", "Refer A Friend", "Other"]
  filter :state, label: "Status", as: :select, collection: Bonus.states
  menu label: "Bonuses"

  index do
    column "User" do |wager|
      link_to(wager.user.name, admin_user_path(wager.user.id))
    end
    column "Bonus Amount" do |bonus|
      number_to_currency bonus.amount_dollars
    end
    column "Pending" do |bonus|
      number_to_currency bonus.pending_dollars
    end
    column "Released" do |bonus|
      number_to_currency bonus.released_dollars
    end
    column :kind
    column :state
    actions
  end

  show do
    attributes_table do
      row "User" do |wager|
        link_to(wager.user.name, admin_user_path(wager.user.id))
      end
      row "Bonus Amount" do
        number_to_currency bonus.amount_dollars
      end
      row "Pending" do
        number_to_currency bonus.pending_dollars
      end
      row "Released" do
        number_to_currency bonus.released_dollars
      end
      row :rollover
      row :kind
      row :state
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Bonus" do
      f.input :user, required: true, as: :select, collection: User.where("role = ? or role = ?", 1, 3).order("name")
      f.input :amount_dollars, label: "Bonus Amount", required: true
      f.input :pending_dollars, label: "Pending"
      f.input :rollover, required: true
      f.input :kind, label: "Bonus Type", as: :select, collection: ["Initial Deposit", "Refer A Friend", "Other"]
      f.input :state, label: "Status", as: :select, collection: ["Pending", "Complete", "Expired"]
    end
    f.actions
  end

  permit_params :user_id, :amount_dollars, :pending_dollars,  :rollover, :kind, :state

end
