ActiveAdmin.register Prop do
  filter :sport
  filter :state, label: "Status", as: :select, collection: Prop.states
  filter :variety, label: "Type", as: :check_boxes, collection: ["Fantasy", "2P Fantasy", "Over/Under", "Other"]
  filter :time, label: "Event Time"
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
    column "Exposure", :exposure
    column :created_at
    actions
  end

  show do
    panel "Prop Choices" do
      table_for prop.prop_choices do
        if prop.variety == "Fantasy"
          column "Choice", :player1
        elsif prop.variety == "2P Fantasy"
          column "Choice" do |choice|
            choice.player1 + " & " + choice.player2
          end
        else
          column "Choice", :choice_raw
        end
        column "Odds", :odds_juice
        if prop.variety == "Other"
          column :winner
        elsif prop.variety == "Fantasy" || prop.variety == "2P Fantasy"
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
      elsif prop.variety == "Fantasy" || prop.variety == "2P Fantasy"
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
    @prop = Prop.find params[:id] unless f.object.new_record?
    if f.object.new_record? || @prop.state == "Offline" || @prop.state == "Open"
      f.inputs "Prop Details" do
        if f.object.new_record?
          f.input :state, label: "Status", as: :radio, collection: ["Offline", "Open"], include_blank: false
        elsif @prop.state == "Graded"
          f.input :state, label: "Status", as: :radio, collection: ["Regrade", "No_Action"], include_blank: false
        else
          f.input :state, label: "Status", as: :radio, collection: ["Offline", "Open", "Closed", "No_Action"]
        end
        f.input :variety, label: "Type", required: true, as: :radio, collection: ["Fantasy", "2P Fantasy", "Over/Under", "Other"]
        f.input :proposition, required: true
        f.input :sport, include_blank: false
        f.input :time, as: :just_datetime_picker, required: true
        f.input :maximum_dollars, label: "Max Win"
        f.input :opt1_spread, label: "Choice 1 Spread", as: :select, collection: (point_spreads), :wrapper_html => { id: "opt1-spread", class: "hidden"}
        f.input :over_under, label: "Over/Under", :wrapper_html => { id: "over-under", class: "hidden"}
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
            s.input :choice_raw, label: "Choice", :wrapper_html => { class: "choice-raw hidden"}, :input_html => { class: "choice"}
            s.input :player1, as: :select, collection: (Player.all), :wrapper_html => { class: "player player1 hidden"}
            s.input :player2, as: :select, collection: (Player.all), :wrapper_html => { class: "player player2 hidden"}
            s.input :odds, as: :select, collection: (vigs)
          else
            if @prop.variety == "Fantasy"
              s.input :player1
              s.input :odds, as: :select, collection: (vigs)
              s.input :score
            elsif @prop.variety == "2P Fantasy"
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
    else
      f.inputs "Prop Choices" do
        f.has_many :prop_choices, new_record: false do |s|
          if @prop.variety == "Fantasy"
            s.input :player1
            s.input :odds, as: :select, collection: (vigs)
            s.input :score
          elsif @prop.variety == "2P Fantasy"
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
      f.inputs "Prop Details" do
        if @prop.variety == "Over/Under"
          f.input :result
        end
        f.input :proposition, required: true
        if @prop.state == "Graded"
          f.input :state, label: "Status", as: :radio, collection: ["Regrade", "No_Action"], include_blank: false
        else
         f.input :state, label: "Status", as: :radio, collection: ["Offline", "Open", "Closed", "No_Action"]
        end
        f.input :variety, label: "Type", required: true, as: :radio, collection: ["Fantasy", "2P Fantasy", "Over/Under", "Other"]
        f.input :sport, include_blank: false
        f.input :time, as: :just_datetime_picker, required: true
        f.input :maximum_dollars, label: "Max Win"
        f.input :opt1_spread, label: "Choice 1 Spread", as: :select, collection: (point_spreads), :wrapper_html => { id: "opt1-spread", class: "hidden"}
        f.input :over_under, label: "Over/Under", :wrapper_html => { id: "over-under", class: "hidden"}
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
