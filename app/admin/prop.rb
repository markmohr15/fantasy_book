ActiveAdmin.register Prop do
  filter :sport
  filter :state, label: "Status", as: :select, collection: Prop.states
  menu priority: 6

  index do
    selectable_column
    column :id
    column :sport
    column "Status", :state do |prop|
      prop.aasm.current_state
    end
    column :time
    column "Max Wager", :maximum_dollars
    column "Home Spread", :home_spread_line
    column "Away Vig", :away_vig_juice
    column "Home Vig", :home_vig_juice
    column :away_score
    column :home_score
    actions
  end

  show do
    attributes_table do
      row :sport
      row "Status", :state do |prop|
        prop.aasm.current_state
      end
      row :time
      row "Max Wager" do
        prop.maximum_dollars
      end
      row :home_spread_line
      row "Away Vig" do
        prop.away_vig_juice
      end
      row "Home Vig" do
        prop.home_vig_juice
      end
      row :away_score
      row :home_score
      row :player1
      row :player2
      row :player3
      row :player4
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Prop Details" do
      @prop = Prop.find params[:id]
      if f.object.new_record?
        f.input :state, label: "Status", as: :select, collection: ["Offline", "Open"], include_blank: false
      elsif @prop.state == "Graded"
        f.input :state, label: "Status", as: :select, collection: ["Regrade", "No_Action"], include_blank: false
      else
        f.input :state, label: "Status", as: :select, collection: ["Offline", "Open", "Closed", "No_Action"], include_blank: false
      end
      unless f.object.new_record?
        if @prop.state == "Closed" or @prop.state == "Graded"
          f.input :away_score
          f.input :home_score
        end
      end
      f.input :sport, include_blank: false
      f.input :time
      f.input :maximum_dollars
      f.input :home_spread, label: "Current/Closing Home Spread", as: :select, collection: (point_spreads)
      f.input :away_vig, label: "Current/Closing Away Vig", as: :select, collection: (vigs)
      f.input :home_vig, label: "Current/Closing Home Vig", as: :select, collection: (vigs)
      f.input :player1, label: "Player 1 (Away)"
      f.input :player2, label: "Player 2 (Away)"
      f.input :player3, label: "Player 3 (Home)"
      f.input :player4, label: "Player 4 (Home)"
    end
    f.actions
  end

  permit_params :sport_id, :state, :time, :maximum_dollars, :home_spread, :away_vig, :home_vig,
   :player1_id, :player2_id, :player3_id, :player4_id, :away_score, :home_score

end
