ActiveAdmin.register Deposit do
  menu priority: 7




  controller do
    before_filter state: :index do
        params[:q] = {state_eq: "Pending"} if params[:commit].blank?
    end
  end

end
