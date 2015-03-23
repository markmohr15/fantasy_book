ActiveAdmin.register Wager do
  filter :id
  filter :user
  filter :prop_id
  filter :state, label: "Status", as: :select, collection: Wager.states
  menu priority: 7
  #custom risk filter

  index do
    selectable_column
    column "Ticket", :id
    column "User" do |wager|
      link_to(wager.user.name, admin_user_path(wager.user.id))
    end
    column "Prop" do |wager|
      link_to(wager.prop.id, admin_prop_path(wager.prop.id))
    end
    column "Status", :state do |wager|
      wager.aasm.current_state
    end
    column "Risk" do |wager|
      number_to_currency wager.risk_dollars
    end
    column "Win" do |wager|
      number_to_currency wager.win_dollars
    end
    column "Result" do |wager|
      number_to_currency wager.result
    end
    column "Placed At", :created_at
    actions
  end

  show do
    attributes_table do
      row "Ticket" do
        wager.id
      end
      row "User" do |wager|
        link_to(wager.user.name, admin_user_path(wager.user.id))
      end
      row "Prop" do |wager|
        link_to(wager.prop.id, admin_prop_path(wager.prop.id))
      end
      row "Status" do |wager|
        wager.aasm.current_state
      end
      row "Risk" do
        number_to_currency wager.risk_dollars
      end
      row "Win" do
        number_to_currency wager.win_dollars
      end
      row "Result" do |wager|
        number_to_currency wager.result
      end
      row "Pick" do |wager|
        wager.prop_choice.name
      end
      row "Spread" do
        wager.spread_line
      end
      row "Odds" do
        wager.odds_juice
      end
      row "Placed At" do
        wager.created_at
      end
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Wager Details" do
      f.input :user, required: true
      f.input :prop_id, as: :select, collection: Prop.where("state = ? or state = ?", 0, 1).collect {|p| ["#{p.proposition} - #{p.prop_choices.first.name} Vs. #{p.prop_choices.last.name}", p.id]}, required: true
      f.input :prop_choice_id, as: :radio, collection: ["Team 1", "Team 2"], required: true
      f.input :risk_dollars, label: "Risk $", required: true
      if f.object.new_record?
        f.input :spread, input_html: { readonly: true }
        f.input :odds, input_html: { readonly: true }
      else
        @wager = Wager.find params[:id]
        f.input :spread_line, input_html: { readonly: true }
        f.input :odds_juice, input_html: { readonly: true }
      end
    end
    f.actions
  end

  permit_params :user_id, :prop_id, :prop_choice_id, :risk_dollars,
   :spread, :odds, :spread_line, :odds_juice

end
