class AccountController < ApplicationController
  layout "account"
  before_action :user_required

  def deposit
    render
  end

  def withdraw
    render
  end

  def transfer
    if params[:receiver].blank?
      @transfers = Transfer.where("receiver_id = ? OR sender_id = ?", current_user.id, current_user.id).order('created_at DESC')
    else
      receiver = User.find_by username: params[:receiver] ||= nil
      if receiver.nil?
        @transfers = Transfer.where("receiver_id = ? OR sender_id = ?", current_user.id, current_user.id).order('created_at DESC')
        flash.now[:alert] = t("account.invalid_username")
        render action: :transfer
      else
        transfer = Transfer.new transfer_params
        transfer.receiver_id = receiver.id
        transfer.sender_id = current_user.id
        if transfer.save
          redirect_to my_account_transfer_path
        else
          render action: :transfer
        end
      end
    end
  end

  def balance
    render
  end

  def challenge
    render
  end

  def social
    render
  end

  private

  def transfer_params
    params.permit(:amount_dollars)
  end

end
