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
    column "Max Win", :maximum_dollars
    actions
  end

  show do
    attributes_table do
      row :sport
      row "Status", :state do |prop|
        prop.aasm.current_state
      end
      row :time
      row "Max Win" do
        prop.maximum_dollars
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Prop Details" do
      @prop = Prop.find params[:id] unless f.object.new_record?
      if f.object.new_record?
        f.input :state, label: "Status", as: :select, collection: ["Offline", "Open"], include_blank: false
      elsif @prop.state == "Graded"
        f.input :state, label: "Status", as: :select, collection: ["Regrade", "No_Action"], include_blank: false
      else
        f.input :state, label: "Status", as: :select, collection: ["Offline", "Open", "Closed", "No_Action"], include_blank: false
      end
      f.input :variety, label: "Type", as: :select, collection: ["PvP", "2Pv2P", "Over/Under", "Other"]
      f.input :proposition
      f.input :sport, include_blank: false
      f.input :time
      f.input :maximum_dollars, label: "Max Win"
      f.input :opt1_spread, label: "Option 1 Spread", as: :select, collection: (point_spreads)
    end
    f.inputs do
      f.has_many :prop_choices, new_record: "New Option" do |s|
        s.input :choice
        s.input :player1
        s.input :player2
        s.input :odds, as: :select, collection: (vigs)
        s.input :score
      end
    end
    f.actions
  end

  permit_params :sport_id, :state, :variety, :proposition, :time, :maximum_dollars, prop_choices_attributes: [:id, :choice,
    :odds, :spread, :score, :player1, :player2]

end
