ActiveAdmin.register Deposit do
  filter :user, as: :select, collection: User.where("role = ? or role = ?", 1, 3).order("username").collect {|u| ["#{u.username}", u.id]}
  filter :kind, label: "Method", as: :select, collection: ["Credit Card", "Paypal", "Other"]
  menu if: proc{ current_user.superadmin? }, priority: 7

  index do
    selectable_column
    column "User" do |deposit|
      link_to(deposit.user.username, admin_user_path(deposit.user.id))
    end
    column "Amount" do |deposit|
      number_to_currency deposit.amount_dollars
    end
    column "Method", :kind
    column :created_at
    actions
  end

  show do
    attributes_table do
      row "User" do |deposit|
        link_to(deposit.user.username, admin_user_path(deposit.user.id))
      end
      row "Amount" do |deposit|
        number_to_currency deposit.amount_dollars
      end
      row "Method" do
        deposit.kind
      end
      row "Stripe ID" do
        deposit.stripe_id
      end
      row "Bonus Code" do
        deposit.bonus_code
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Deposit" do
      @deposit = Deposit.find params[:id] unless f.object.new_record?
      f.input :user, as: :select, collection: User.where("role = ? or role = ?", 1, 3).order("username").collect {|u| ["#{u.username}", u.id]}
      f.input :amount_dollars, label: "Amount"
      f.input :kind, label: "Method"
    end
    f.actions
  end

  permit_params :user_id, :amount_dollars, :kind

  controller do
    before_filter :superadmin_filter

    def superadmin_filter
      raise ActionController::RoutingError.new "Not Found" unless current_user.role == "superadmin"
    end

  end

end

