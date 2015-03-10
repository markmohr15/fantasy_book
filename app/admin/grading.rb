ActiveAdmin.register Prop, as: "Grading" do
  actions :edit, :update, :index
  filter :sport
  filter :state, label: "Status", as: :select, collection: Prop.states
  filter :time, label: "Event Time"
  menu priority: 9
  menu label: "Grading"
  config.clear_action_items!



  index title: "Grading" do
    selectable_column
    column :id
    column :sport
    column "Status", :state do |grading|
      grading.aasm.current_state
    end
    column "Event Time", :time
    column "Exposure (Max Loss)", :exposure_to_s
    column :winner
    column :created_at
    actions
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
