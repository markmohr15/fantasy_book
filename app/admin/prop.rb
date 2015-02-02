ActiveAdmin.register Prop do
  filter :sport
  filter :state, label: "Status", as: :select, collection: Prop.states
  filter :variety, label: "Type"
  menu priority: 6

  index do
    selectable_column
    column :id
    column :sport
    column "Status", :state do |prop|
      prop.aasm.current_state
    end
    column "Type", :variety
    column "Event Time", :time
    column "Max Win", :maximum_dollars
    actions
  end

  show do
    panel "Prop Choices" do
      table_for prop.prop_choices do
        if prop.variety == "PvP"
          column "Choice", :player1
        elsif prop.variety == "2Pv2P"
          column "Choice" do |choice|
            choice.player1 + " & " + choice.player2
          end
        else
          column "Choice", :choice_raw
        end
        column "Odds", :odds_juice
        if prop.variety == "Other"
          column :winner
        elsif prop.variety == "PvP" || prop.variety == "2Pv2P"
          column :score
        end
      end
    end
  end

  sidebar "Prop Info", only: [:show] do
    attributes_table_for prop do
      row "Status", :state do |prop|
        prop.aasm.current_state
      end
      row "Type" do
        prop.variety
      end
      row :sport
      row :proposition
      if prop.variety == "Over/Under"
        row :over_under
        row :result
      elsif prop.variety == "PvP" || prop.variety == "2Pv2P"
        row "Choice 1 Spread" do
          prop.opt1_spread_line
        end
      end
      row "Event Time" do
        prop.time
      end
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
      f.input :variety, label: "Type", required: true, as: :select, collection: ["PvP", "2Pv2P", "Over/Under", "Other"]
      f.input :proposition, required: true
      f.input :sport, include_blank: false
      f.input :time, as: :just_datetime_picker, required: true
      f.input :maximum_dollars, label: "Max Win"
      f.input :opt1_spread, label: "Choice 1 Spread", as: :select, collection: (point_spreads)
      f.input :over_under, label: "Over/Under"
      unless f.object.new_record?
        if @prop.variety == "Over/Under"
          f.input :result
        end
      end
    end
    f.inputs "Prop Choices" do
      (2 - f.object.prop_choices.count).times do
        f.object.prop_choices.build
      end
      f.has_many :prop_choices, new_record: "New Option" do |s|
        if f.object.new_record?
          s.input :choice_raw, label: "Choice"
          s.input :player1, as: :select, collection: (Player.all)
          s.input :player2, as: :select, collection: (Player.all)
          s.input :odds, as: :select, collection: (vigs)
        else
          if @prop.variety == "PvP"
            s.input :player1
            s.input :odds, as: :select, collection: (vigs)
            s.input :score
          elsif @prop.variety == "2Pv2P"
            s.input :player1
            s.input :player2
            s.input :odds, as: :select, collection: (vigs)
            s.input :score
          elsif @prop.variety == "Over/Under"
            s.input :choice_raw, label: "Choice"
            s.input :odds, as: :select, collection: (vigs)
          else
            s.input :choice_raw, label: "Choice"
            s.input :odds, as: :select, collection: (vigs)
            s.input :winner
          end
        end
      end
    end
    f.actions
  end

  controller do
    def create
      params[:prop][:prop_choices_attributes].each do |k,v|
        if v['choice_raw'] == "" && v['player1'] == ""
          params[:prop][:prop_choices_attributes].delete k
        end
      end
      super
    end

    def update
      params[:prop][:prop_choices_attributes].each do |k,v|
        if v['choice_raw'] == "" && v['player1'] == ""
          params[:prop][:prop_choices_attributes].delete k
        end
      end
      super
    end
  end

  permit_params :sport_id, :state, :variety, :proposition, :time_date,
  :time_time_hour, :time_time_minute, :maximum_dollars, :opt1_spread, :over_under, :result,
   prop_choices_attributes: [:id, :choice_raw, :odds, :score, :player1, :player2, :winner]

end
