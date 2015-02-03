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
    column :user
    column :prop
    column "Status", :state do |wager|
      wager.aasm.current_state
    end
    column "Risk", :risk_dollars
    column "Win", :win_dollars
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :prop
      row "Status", :state do |wager|
        wager.aasm.current_state
      end
      row "Risk" do
        wager.risk_dollars
      end
      row "Win" do
        wager.win_dollars
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
      f.input :win_dollars, label: "Win"
      f.input :prop_choice_id
      if f.object.new_record?
        f.input :spread, collection: options_for_select(["4", "5", "pk"], "pk")
        f.input :total
        f.input :odds, collection: options_for_select(["-110", "-114", "-118"], "-110")
      else
        @wager = Wager.find params[:id]
        if @wager.prop.variety == "Over/Under"
          f.input :total
        elsif @wager.prop.variety == "PvP" || @wager.prop.variety == "2Pv2P"
          f.input :spread_line
        end
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

  permit_params :user_id, :prop_id, :state, :risk_dollars, :win_dollars, :prop_choice_id,
   :spread, :spread_line, :total, :odds, :odds_juice

end
