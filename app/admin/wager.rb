ActiveAdmin.register Wager do
  filter :id
  filter :user
  filter :prop_id
  filter :state, label: "Status", as: :select, collection: Wager.states
  menu priority: 7
  #custom risk filter

  #  id             :integer          not null, primary key
#  prop_id        :integer
#  user_id        :integer
#  state          :integer          default("0")
#  risk           :integer
#  win            :integer
#  prop_choice_id :integer
#  odds           :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  spread         :float(24)

  index do
    selectable_column
    column "Ticket", :id
    column "User" do |wager|
      link_to(wager.user.name, admin_user_path(wager.user.id))
    end
    column "Prop" do |wager|
      link_to(wager.prop.id, admin_prop_path(wager.prop.id))
    end
    column "Status", :state do |wager|
      wager.aasm.current_state
    end
    column "Risk" do |wager|
      number_to_currency wager.risk_dollars
    end
    column "Win" do |wager|
      number_to_currency wager.win_dollars
    end
    column "Result" do |wager|
      number_to_currency wager.result
    end
    column "Placed At", :created_at
    actions
  end

  show do
    attributes_table do
      row "Ticket" do
        wager.id
      end
      row "User" do |wager|
        link_to(wager.user.name, admin_user_path(wager.user.id))
      end
      row "Prop" do |wager|
        link_to(wager.prop.id, admin_prop_path(wager.prop.id))
      end
      row "Status" do |wager|
        wager.aasm.current_state
      end
      row "Risk" do
        number_to_currency wager.risk_dollars
      end
      row "Win" do
        number_to_currency wager.win_dollars
      end
      row "Result" do |wager|
        number_to_currency wager.result
      end
      row "Pick" do |wager|
        wager.prop_choice.name
      end
      row "Spread" do
        wager.spread_line
      end
      row "Odds" do
        wager.odds_juice
      end
      row "Placed At" do
        wager.created_at
      end
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Wager Details" do
      f.input :user
      f.input :prop_id
      f.input :state, label: "Status", as: :select, collection: f.object.aasm.states.map(&:name), include_blank: false
      f.input :risk_dollars, label: "Risk"
      f.input :prop_choice_id
      if f.object.new_record?
        f.input :spread, as: :select, collection: (point_spreads)
        f.input :odds, as: :select, collection: (vigs)
      else
        @wager = Wager.find params[:id]
        f.input :odds_juice
      end
    end
    f.actions
  end

  permit_params :user_id, :prop_id, :state, :risk_dollars, :prop_choice_id,
   :spread, :odds, :odds_juice

end
