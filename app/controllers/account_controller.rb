class AccountController < ApplicationController
  layout "account"
  before_action :user_required

  def deposit
    render
  end

  def withdraw
    @options = ["ACH", "Check"]
    @withdrawals = Withdrawal.where(user_id: current_user.id).order('created_at DESC')
    if params[:amount_dollars].blank?

    else
      withdrawal = Withdrawal.new withdrawal_params
      withdrawal.user_id = current_user.id
      if withdrawal.save
        redirect_to my_account_withdraw_path
        MailgunMailer.withdrawal_request(withdrawal).deliver_later
      else
        flash.now[:alert] = t("account.insufficient_funds")
        render action: :withdraw
      end
    end
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
          MailgunMailer.transfer_request(transfer).deliver_later
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

  def bonuses
    @bonuses = Bonus.where(user_id: current_user.id).order("created_at DESC" )
  end

  def affiliate
    redirect_to root_path unless current_user.affiliate?
    @aps = AffiliatePayment.where(affiliate_id: current_user.id).order("created_at DESC")
  end

  private

  def transfer_params
    params.permit(:amount_dollars)
  end

  def withdrawal_params
    params.permit(:amount_dollars, :method)
  end

end
