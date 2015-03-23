ActiveAdmin.register User do
  actions :all
  filter :email
  filter :username
  filter :role, as: :select, collection: (player_or_vip)
  menu priority: 3

  index do
    selectable_column
    column :email
    column :name
    column :username
    column :phone
    column "Balance", :balance_dollars do |user|
      number_to_currency user.balance_dollars
    end
    column "Overall Results" do |user|
      number_to_currency Wager.player_results(user, "2015-01-01 00:00:00", Time.now)
    end
    actions
  end

  show do
    attributes_table do
      row :email
      row :name
      row :username
      row "Balance", :balance_dollars do |user|
        number_to_currency user.balance_dollars
      end
      row "Overall Results" do |user|
        number_to_currency Wager.player_results(user, "2015-01-01 00:00:00", Time.now)
      end
      row :address
      row :city
      row :state
      row :zip
      row :country
      row :phone
      row :role
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :created_at
      row :updated_at
    end
  end

  sidebar "House Credits", only: [:show] do
    table_for user.credits do
      column "Amount", :amount_dollars
      column :admin
      column :created_at
    end
  end

  form do |f|
    @user = User.find params[:id] unless f.object.new_record?
    f.inputs "User Details" do
      f.input :email
      f.input :name
      f.input :username
      if f.object.new_record?
        f.input :password
      end
      f.input :address
      f.input :city
      f.input :state, as: :select, collection: (us_states)
      f.input :zip
      f.input :country, as: :select, collection: ["USA", "Canada", "Mexico"]
      f.input :phone
      f.input :role, as: :radio, collection: [["Player", "player", {checked: true}], ["VIP", "vip"]]
    end
    f.inputs do
      f.has_many :credits, new_record: "House Credit" do |c|
        c.input :amount_dollars, label: "Amount"
        c.input :note
        c.input :user_id, input_html: { value: @user.id }, as: :hidden
        c.input :admin_id, input_html: { value: current_user.id }, as: :hidden
      end
    end
    f.actions
  end

  permit_params :email, :name, :username, :password, :balance_dollars, :address,
  :city, :state, :zip, :country, :phone, :role, credits_attributes: [:id, :amount_dollars, :note, :user_id, :admin_id]

  controller do
    def scoped_collection
      User.where("role = ? or role = ?", 1, 3)
    end
  end


end
