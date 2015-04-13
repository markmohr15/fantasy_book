ActiveAdmin.register AffiliatePayment do
  filter :user, as: :select, collection: User.where(affiliate: true).order("username").collect {|u| ["#{u.username}", u.id]}
  filter :state, label: "Status", as: :select, collection: AffiliatePayment.states
  menu priority: 13

  index do
    column "Affiliate" do |ap|
      link_to(ap.affiliate.username, admin_user_path(ap.affiliate.id))
    end
    column "Player" do |ap|
      link_to(ap.user.username, admin_user_path(ap.user.id))
    end
    column "Amount" do |ap|
      number_to_currency ap.amount_dollars
    end
    column "Status" do |ap|
      ap.state
    end
  end

  show do
    attributes_table do
      row "Affiliate" do |ap|
        link_to(ap.affiliate.username, admin_user_path(ap.affiliate.id))
      end
      row "Player" do |ap|
        link_to(ap.user.username, admin_user_path(ap.user.id))
      end
      row "Amount" do |ap|
        number_to_currency ap.amount_dollars
      end
      row "Status" do |ap|
        ap.state
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Affiliate Payment" do
      f.input :affiliate, label: "Affiliate", as: :select, collection: User.where(affiliate: true).order("username").collect {|u| ["#{u.username}", u.id]}
      f.input :user, label: "Player", as: :select, collection: User.where("role = ? or role = ?", 1, 3).order("username").collect {|u| ["#{u.username}", u.id]}
      f.input :amount_dollars, label: "Amount"
      f.input :state, label: "Status", as: :radio, collection: ["Pending", "Approved", "Rejected"]
    end
    f.actions
  end

  permit_params :affiliate_id, :user_id, :amount_dollars, :state

  controller do
    before_filter state: :index do
        params[:q] = {state_eq: "Pending"} if params[:commit].blank?
    end
  end
end
