ActiveAdmin.register Prop, as: "Grading" do
  actions :index
  menu label: "Grading", priority: 6
  filter :sport
  filter :time, label: "Event Time"
  config.batch_actions = false

  index as: :block, title: "Grading" do |grading|
    div for: grading, class: "grade-prop", "data-propid" => grading.id do
      h3 grading.sport.name
      h5 grading.time.strftime("%B %-d, %Y %n %l:%M %P EST")
      if grading.proposition != "Vs."
        div grading.proposition
      end
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
        button_tag "NA", class: "noAction"
      end
    end
  end

  controller do
    def scoped_collection
      Prop.where state: 2
    end
  end

end
