ActiveAdmin.register Withdrawal do
  filter :state, label: "Status", as: :select, collection: Withdrawal.states
  filter :user, as: :select, collection: User.where("role = ? or role = ?", 1, 3).order("username").collect {|u| ["#{u.username}", u.id]}
  filter :kind, label: "Method", as: :select, collection: ["ACH", "Check"]
  menu if: proc{ current_user.superadmin? }, priority: 8

  index do
    selectable_column
    column "User" do |withdrawal|
      link_to(withdrawal.user.username, admin_user_path(withdrawal.user.id))
    end
    column "Net Amount" do |withdrawal|
      number_to_currency withdrawal.net_amount
    end
    column "Status" do |withdrawal|
      withdrawal.state
    end
    column "Method", :kind
    column :created_at
    actions
  end

  show do
    attributes_table do
      row "User" do |withdrawal|
        link_to(withdrawal.user.username, admin_user_path(withdrawal.user.id))
      end
      row "Amount" do |withdrawal|
        number_to_currency withdrawal.amount_dollars
      end
      row "Fee" do |withdrawal|
        number_to_currency withdrawal.fee_dollars
      end
      row "Net Amount" do |withdrawal|
        number_to_currency withdrawal.net_amount
      end
      row "Status" do |withdrawal|
        withdrawal.state
      end
      row "Method" do
        withdrawal.kind
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Withdrawal" do
      @withdrawal = Withdrawal.find params[:id] unless f.object.new_record?
      f.input :user, as: :select, collection: User.where("role = ? or role = ?", 1, 3).order("username").collect {|u| ["#{u.username}", u.id]}
      f.input :amount_dollars, label: "Amount"
      f.input :fee_dollars
      f.input :kind, label: "Method"
      if f.object.new_record?
        f.input :state, as: :radio, collection: ["Pending", "Approved"]
      else
        if @withdrawal.state == "Pending"
          f.input :state, as: :radio, collection: ["Pending", "Approved", "Rejected"]
        end
      end
    end
    f.actions
  end

  permit_params :user_id, :amount_dollars, :fee_dollars, :kind, :state

  controller do
    before_filter :superadmin_filter

    def superadmin_filter
      raise ActionController::RoutingError.new "Not Found" unless current_user.role == "superadmin"
    end

    before_filter state: :index do
        params[:q] = {state_eq: "Pending"} if params[:commit].blank?
    end
  end

end
