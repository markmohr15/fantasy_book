ActiveAdmin.register Transfer do
  menu priority: 8
  filter :sender
  filter :receiver
  filter :state, label: "Status"

  index do
    selectable_column
    column :sender
    column :receiver
    column "Amount", :amount_dollars
    column "Status", :state
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :sender
      row :receiver
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
    f.inputs "Transfer" do
      @transfer = Transfer.find params[:id] unless f.object.new_record?
      f.input :sender, as: :select, collection: (User.where role: 1)
      f.input :receiver, as: :select, collection: (User.where role: 1)
      f.input :amount_dollars, label: "Amount"
      if f.object.new_record?
        f.input :state, as: :select, collection: ["Pending", "Approved", "Rejected"], include_blank: false
      else
        if @transfer.state == "Pending"
          f.input :state, as: :select, collection: ["Pending", "Approved", "Rejected"], include_blank: false
        end
      end
    end
    f.actions
  end

  permit_params :sender_id, :receiver_id, :amount_dollars, :state

end
