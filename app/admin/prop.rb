ActiveAdmin.register Prop do

  filter :sport
  filter :state

  index do
    selectable_column
    column :sport
    column :state, as: :select, collection: Prop.states
    column :time
    column :home_spread
    column :away_vig
    column :home_vig
    column :winner
    actions
  end

  show do
    attributes_table do
      row :sport
      row :state
      row :time
      row :home_spread
      row :away_vig
      row :home_vig
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
      f.input :sport
      f.input :state
      f.input :time
      f.input :home_spread, as: :select, collection: (point_spreads)
      f.input :away_vig, as: :select, collection: (vigs)
      f.input :home_vig, as: :select, collection: (vigs)
      f.input :player1, label: "Player 1 (Away)"
      f.input :player2, label: "Player 2 (Away)"
      f.input :player3, label: "Player 3 (Home)"
      f.input :player4, label: "Player 4 (Home)"
    end
    f.actions
  end

  permit_params :sport_id, :state, :time, :home_spread, :away_vig, :home_vig, :player1_id, :player2_id, :player3_id, :player4_id

end
