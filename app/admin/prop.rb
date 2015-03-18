ActiveAdmin.register Prop do
  filter :sport
  filter :state, label: "Status", as: :select, collection: Prop.states
  filter :time, label: "Event Time"
  menu priority: 6

  index do
    selectable_column
    column :id
    column :sport
    column "Status", :state do |prop|
      prop.aasm.current_state
    end
    column "Event Time", :time
    column "Team 1 Available" do |prop|
      prop.prop_choices.first.available_dollars
    end
    column "Team 2 Available" do |prop|
      prop.prop_choices.last.available_dollars
    end
    column :winner
    column :created_at
    actions
  end

  show do
    panel "Prop Choices" do
      table_for prop.prop_choices do
        column "Choice" do |prop|
          prop.name
        end
        column "Odds", :odds_juice
        column "Max Available", :available_dollars
      end
    end
  end

  sidebar "Prop Info", only: [:show] do
    attributes_table_for prop do
      row "Status", :state do |prop|
        prop.aasm.current_state
      end
      row :sport
      row :proposition
      row "Event Time" do
        prop.time
      end
      row :user
      row "Choice 1 Spread" do
        prop.opt1_spread_line
      end
      row :winner
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    @prop = Prop.find params[:id] unless f.object.new_record?
    f.inputs "Prop Details" do
      if f.object.new_record?
        f.input :state, label: "Status", as: :radio, collection: ["Offline", "Open"], include_blank: false
      elsif @prop.state == "Graded"
        f.input :state, label: "Status", as: :radio, collection: ["Regrade", "No_Action"], include_blank: false
      else
        f.input :state, label: "Status", as: :radio, collection: ["Offline", "Open", "Closed", "No_Action"]
      end
      f.input :proposition, required: true, input_html: { value: "Vs."}
      f.input :sport, include_blank: false
      f.input :time, as: :just_datetime_picker, required: true
      f.input :user, label: "VIP Acct", as: :select, collection: User.where(role: 3), required: true, include_blank: false
      f.input :opt1_spread, label: "Choice 1 Spread", as: :select, collection: (point_spreads), :wrapper_html => { id: "opt1-spread", class: "hidden"}
      f.input :winner, as: :radio, collection: ["Team1", "Team2", "Push", "NoAction"]
    end
    f.inputs "Prop Choices" do
      (2 - f.object.prop_choices.count).times do
        f.object.prop_choices.build
      end
      f.has_many :prop_choices, new_record: false do |s|
        if f.object.new_record?
          s.input :player1, as: :select, collection: (Player.all), wrapper_html: { class: "player1"}, required: true
          s.input :player2, as: :select, collection: (Player.all), wrapper_html: { class: "player2 hidden"}
          s.input :player3, as: :select, collection: (Player.all), wrapper_html: { class: "player3 hidden"}
          s.input :player4, as: :select, collection: (Player.all), wrapper_html: { class: "player4 hidden"}
          s.input :player5, as: :select, collection: (Player.all), wrapper_html: { class: "player5 hidden"}
          s.input :odds, as: :select, collection: (vigs)
          s.input :available_dollars, label: "Max Available", wrapper_html: { class: "available"}
        else
          s.input :player1, wrapper_html: { class: "player player1e"}
          s.input :player2, wrapper_html: { class: "player player2e hidden"}
          s.input :player3, wrapper_html: { class: "player player3e hidden"}
          s.input :player4, wrapper_html: { class: "player player4e hidden"}
          s.input :player5, wrapper_html: { class: "player player5e hidden"}
          s.input :odds, as: :select, collection: (vigs)
          s.input :available_dollars, label: "Max Available", wrapper_html: { class: "available"}
        end
      end
    end
    f.actions
  end

  permit_params :sport_id, :state, :proposition, :time_date,
  :time_time_hour, :time_time_minute, :user_id, :opt1_spread, :winner,
   prop_choices_attributes: [:id, :odds, :player1, :player2,
    :player3, :player4, :player5, :available_dollars]

end
