ActiveAdmin.register Transfer do
  menu priority: -10
  filter :sender, as: :select, collection: User.where("role = ? or role = ?", 1, 3).order("username").collect {|u| ["#{u.username}", u.id]}
  filter :receiver, as: :select, collection: User.where("role = ? or role = ?", 1, 3).order("username").collect {|u| ["#{u.username}", u.id]}
  filter :state, label: "Status", as: :select, collection: Transfer.states

  index do
    selectable_column
    column "Sender" do |transfer|
      link_to(transfer.sender.username, admin_user_path(transfer.sender.id))
    end
    column "Receiver" do |transfer|
      link_to(transfer.receiver.username, admin_user_path(transfer.receiver.id))
    end
    column "Amount", :amount_dollars
    column "Status", :state do |transfer|
      transfer.state
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row "Sender" do |transfer|
        link_to(transfer.sender.username, admin_user_path(transfer.sender.id))
      end
      row "Receiver" do |transfer|
        link_to(transfer.receiver.username, admin_user_path(transfer.receiver.id))
      end
      row "Amount" do
        number_to_currency transfer.amount_dollars
      end
      row "Status" do
        transfer.state
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Transfer" do
      @transfer = Transfer.find params[:id] unless f.object.new_record?
      f.input :sender, required: true, as: :select, collection: User.where("role = ? or role = ?", 1, 3).order("username").collect {|u| ["#{u.username}", u.id]}
      f.input :receiver, required: true, as: :select, collection: User.where("role = ? or role = ?", 1, 3).order("username").collect {|u| ["#{u.username}", u.id]}
      f.input :amount_dollars, label: "Amount"
      if f.object.new_record?
        f.input :state, as: :radio, collection: ["Pending", "Approved"]
      else
        if @transfer.state == "Pending"
          f.input :state, as: :radio, collection: ["Pending", "Approved", "Rejected"]
        end
      end
    end
    f.actions
  end

  permit_params :sender_id, :receiver_id, :amount_dollars, :state

end

