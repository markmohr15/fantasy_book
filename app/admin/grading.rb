ActiveAdmin.register Prop, as: "Grading" do
  actions :edit, :update, :index
  filter :sport
  filter :state, label: "Status", as: :select, collection: Prop.states
  filter :time, label: "Event Time"
  menu priority: 9
  menu label: "Grading"
  config.clear_action_items!
  config.batch_actions = false

  index as: :block, title: "Grading" do |grading|
    div for: grading, class: "prop" do
      h3 grading.sport.name
      h5 grading.time.strftime("%B %-d, %Y %n %l:%M %P EST")
      div "Team 1: " + grading.prop_choices.first.name + " " + grading.opt1_spread_line.to_s
      div "Team 2: " + grading.prop_choices.last.name + " " + grading.opt2_spread_line.to_s
      div class: "grade" do
        button_tag "T1", class: "team1"
      end
      div class: "grade" do
        button_tag "T2", class: "team2"
      end
      div class: "grade" do
        button_tag "Push", class: "push"
      end
      div class: "grade" do
        button_tag "NA", class: "noAction" # button_tag "Team2" #button_tag "Push" button_tag "No Action"
      end
    end
  end

  sidebar "Prop Info", only: [:edit] do
    attributes_table_for grading do
      row "Status", :state do |grading|
        grading.aasm.current_state
      end
      row :sport
      row :proposition
      row "Choice 1 Spread" do
        grading.opt1_spread_line
      end
      row "Team 1" do
        grading.prop_choices.first.name
      end
      row "Team 2" do
        grading.prop_choices.last.name
      end
      row "Event Time" do
        grading.time
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
      if @prop.state == "Graded"
        f.input :state, as: :radio, collection: ["Regrade"], input_html: { checked: 'checked', readonly: true }
      end
      f.input :winner, as: :radio, collection: ["Team1", "Team2", "Push", "NoAction"]
    end
    f.actions
  end

  permit_params :state, :winner

  controller do
    def scoped_collection
      Prop.where("state = ? or state = ?", 2, 3)
    end
  end

end
