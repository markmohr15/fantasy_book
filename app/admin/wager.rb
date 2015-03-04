ActiveAdmin.register Wager do
  filter :id
  filter :user
  filter :prop_id
  filter :state, label: "Status", as: :select, collection: Wager.states
  menu priority: 7
  #custom risk filter

  index do
    selectable_column
    column :id
    column "User" do |wager|
      link_to(wager.user.name, admin_user_path(wager.user.id))
    end
    column :prop
    column "Status", :state do |wager|
      wager.aasm.current_state
    end
    column "Risk", :risk_dollars do |wager|
      number_to_currency wager.risk_dollars
    end
    column "Win", :win_dollars do |wager|
      number_to_currency wager.win_dollars
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row "User" do |wager|
        link_to(wager.user.name, admin_user_path(wager.user.id))
      end
      row :prop
      row "Status", :state do |wager|
        wager.aasm.current_state
      end
      row "Risk" do
        number_to_currency wager.risk_dollars
      end
      row "Win" do
        number_to_currency wager.win_dollars
      end
      row "Pick" do |wager|
        wager.prop_choice
      end
      row "Spread" do
        wager.spread_line
      end
      row :total
      row "Odds" do
        wager.odds_juice
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Wager Details" do
      f.input :user
      f.input :prop_id
      f.input :state, label: "Status", as: :select, collection: f.object.aasm.states.map(&:name), include_blank: false
      f.input :risk_dollars, label: "Risk"
      f.input :prop_choice_id
      if f.object.new_record?
        f.input :spread, as: :select, collection: (point_spreads)
        f.input :total
        f.input :odds, as: :select, collection: (vigs)
      else
        @wager = Wager.find params[:id]
        f.input :odds_juice
      end
    end
    f.actions
  end

  #controller do
   # def scoped_collection
    #  User.where(role: "player")
    #end
  #end

  permit_params :user_id, :prop_id, :state, :risk_dollars, :prop_choice_id,
   :spread, :spread_line, :total, :odds, :odds_juice

end
