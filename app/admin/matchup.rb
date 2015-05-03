ActiveAdmin.register Wager, as: "Matchup" do
  filter :state, label: "Status", as: :select, collection: Wager.states, input_html: { value: "Pending" }
  filter :id
  filter :user, as: :select, collection: User.where("role = ?", 1).order("username").collect {|u| ["#{u.username}", u.id]}
  filter :prop_id
  menu priority: 5
  #custom risk filter

  index do
    selectable_column
    column "Ticket", :id
    column "User" do |matchup|
      link_to(matchup.user.username, admin_user_path(matchup.user.id))
    end
    column "Prop" do |matchup|
      link_to(matchup.prop.id, admin_prop_path(matchup.prop.id))
    end
    column "Status", :state do |matchup|
      matchup.aasm.current_state
    end
    column "Pick" do |matchup|
      matchup.prop_choice.name
    end
    column "Opponent" do |matchup|
      matchup.opponent
    end
    column "Risk" do |matchup|
      number_to_currency matchup.risk_dollars
    end
    column "Win" do |matchup|
      number_to_currency matchup.win_dollars
    end
    column "Result" do |matchup|
      number_to_currency matchup.result
    end
    column "Placed At", :created_at
    actions
  end

  show do
    attributes_table do
      row "Ticket" do |matchup|
        matchup.id
      end
      row "User" do |matchup|
        link_to(matchup.user.username, admin_user_path(matchup.user.id))
      end
      row "Prop" do |matchup|
        link_to(matchup.prop.id, admin_prop_path(matchup.prop.id))
      end
      row "Status" do |matchup|
        matchup.aasm.current_state
      end
      row "Risk" do |matchup|
        number_to_currency matchup.risk_dollars
      end
      row "Win" do |matchup|
        number_to_currency matchup.win_dollars
      end
      row "Result" do |matchup|
        number_to_currency matchup.result
      end
      row "Pick" do |matchup|
        matchup.prop_choice.name
      end
      row "Spread" do |matchup|
        matchup.spread_line
      end
      row "Odds" do |matchup|
        matchup.odds_juice
      end
      row "Placed At" do |matchup|
        matchup.created_at
      end
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Matchup Details" do
      f.input :user, required: true, as: :select, collection: User.where("role = ? or role = ?", 1, 3).order("username").collect {|u| ["#{u.username}", u.id]}, include_blank: false
      f.input :prop_id, as: :select, collection: Prop.where("state = ?", 1).collect {|p| ["#{p.prop_choices.first.name} Vs. #{p.prop_choices.last.name}", p.id]}, required: true
      f.input :prop_choice_id, label: "Selection", as: :radio, collection: ["Team 1", "Team 2"], required: true, include_blank: false
      f.input :risk_dollars, label: "Risk $", required: true
      if f.object.new_record?
        f.input :spread, input_html: { readonly: true }
        f.input :odds, input_html: { readonly: true }
      else
        @matchup = Wager.find params[:id]
        f.input :spread_line, label: "Spread", input_html: { readonly: true }
        f.input :odds_juice, label: "Odds", input_html: { readonly: true }
      end
    end
    f.actions
  end

  permit_params :user_id, :prop_id, :prop_choice_id, :risk_dollars,
   :spread, :odds, :spread_line, :odds_juice

  controller do

    def scoped_collection
      Wager.joins(:user).where('users.role' => 1)
    end

    before_filter state: :index do
        params[:q] = {state_eq: "Pending"} if params[:commit].blank?
    end
  end

end
