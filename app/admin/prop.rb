ActiveAdmin.register Prop do

  filter :sport
  filter :state, label: "Status", as: :select, collection: Prop.states

  index do
    selectable_column
    column :sport
    column "Status", :state do |prop|
      prop.aasm.current_state
    end
    column :time
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
      unless f.object.new_record?
        @prop = Prop.find params[:id]
        if @prop.state == "Closed"
          f.input :away_score
          f.input :home_score
        end
      end
      f.input :sport, include_blank: false
      if f.object.new_record?
        f.input :state, label: "Status", as: :select, collection: ["Offline", "Open"], include_blank: false
      else
        f.input :state, label: "Status", as: :select, collection: ["Offline", "Open", "Closed", "No_Action"], include_blank: false
      end
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

  controller do

    def update
      @prop = Prop.find params[:id]
      if params[:prop][:away_score].present? && params[:prop][:home_score].present?
        params[:prop].delete :state
        @prop.grade_prop!
      end
      super
    end
  end

  permit_params :sport_id, :state, :time, :home_spread, :away_vig, :home_vig,
   :player1_id, :player2_id, :player3_id, :player4_id, :winner

end
