ActiveAdmin.register Prop do

  filter :sport
  filter :state, label: "Status", as: :select, collection: Prop.states

  index do
    selectable_column
    column :sport
    column "Status", :state do |prop|
      prop.aasm_current_state
    end
    column :time
    column "Home Spread", :home_spread_line
    column "Away Vig", :away_vig_juice
    column "Home Vig", :home_vig_juice
    column :winner
    actions
  end

  show do
    attributes_table do
      row :sport
      row "Status", :state do |prop|
        prop.aasm_current_state
      end
      row :time
      row :home_spread_line
      row "Away Vig" do
        prop.away_vig_juice
      end
      row "Home Vig" do
        prop.home_vig_juice
      end
      row :winner
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
      f.input :sport, include_blank: false
      f.input :state, label: "Status", as: :select, collection: f.object.aasm.states.map(&:name), include_blank: false
      f.input :time
      f.input :home_spread, label: "Home Spread", as: :select, collection: (point_spreads)
      f.input :away_vig, label: "Away Vig", as: :select, collection: (vigs)
      f.input :home_vig, label: "Home Vig", as: :select, collection: (vigs)
      f.input :player1, label: "Player 1 (Away)"
      f.input :player2, label: "Player 2 (Away)"
      f.input :player3, label: "Player 3 (Home)"
      f.input :player4, label: "Player 4 (Home)"
    end
    f.actions
  end

  permit_params :sport_id, :state, :time, :home_spread, :away_vig, :home_vig, :player1_id, :player2_id, :player3_id, :player4_id

end
