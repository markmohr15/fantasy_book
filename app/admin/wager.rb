ActiveAdmin.register Wager do

  filter :id
  filter :user
  filter :props
  filter :state
  filter :risk

  index do
    selectable_column
    column :id
    column :user
    column :prop
    column :state
    column :risk_dollars
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :prop
      row :state
      row :risk_dollars
      row :win_dollars
      row :state
      row "Pick" do |wager|
        if wager.pick == "away"
          wager.prop.player1.name + " & " + wager.prop.player2.name
        else
          wager.prop.player3.name + " & " + wager.prop.player4.name
        end
      end
      row :spread_line
      row :vig
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Wager Details" do
      f.input :user
      f.input :prop
      f.input :state
      f.input :risk_dollars
      f.input :win_dollars
      f.input :pick, as: :select, collection: ["away", "home"]
      f.input :spread, as: :select, collection: (point_spreads)
      f.input :vig, as: :select, collection: (vigs)

    end
    f.actions
  end

  #controller do
   # def scoped_collection
    #  User.where(role: "player")
    #end
  #end

  permit_params :user_id, :prop, :state, :risk_dollars, :win_dollars, :pick, :vig

end
