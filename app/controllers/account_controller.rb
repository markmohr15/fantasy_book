class AccountController < ApplicationController
  layout "account"
  before_action :user_required

  def deposit
    @deposits = Deposit.where(user_id: current_user.id).order('created_at DESC')
  end

  def charge_card
    @amount = params[:amount_dollars].to_f * 100

    if current_user.stripe_customer_id.blank?
      customer = Stripe::Customer.create(
        :email => current_user.email,
        :card  => params[:stripeToken]
      )
    else
      customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
    end

    if charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount.to_i,
      :description => "FantasyBook.guru",
      :currency    => "usd"
    )
      deposit = Deposit.new(deposit_params)
      deposit.user_id = current_user.id
      deposit.kind = "Credit Card"
      deposit.stripe_id = charge.id
      current_user.stripe_customer_id = customer.id
      current_user.save
      deposit.save
    end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to my_account_deposit_path
  end

  def withdraw
    @options = ["Check"]
    @withdrawals = Withdrawal.where(user_id: current_user.id).order('created_at DESC')
    unless params[:amount_dollars].blank?
      withdrawal = Withdrawal.new withdrawal_params
      withdrawal.user_id = current_user.id
      if withdrawal.save
        redirect_to my_account_withdraw_path
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

  def bc
    respond_to do |format|
      format.json do
        bonus_code_name = params[:bonus_code_name]
        @check = BonusCode.find_by code: bonus_code_name
        if @check.nil?
          response = "Invalid Code"
        else
          response = ""
        end
        render json: response.to_json
      end
    end
  end

  private

  def transfer_params
    params.permit(:amount_dollars)
  end

  def withdrawal_params
    params.permit(:amount_dollars, :kind)
  end

  def deposit_params
    params.permit(:amount_dollars, :bonus_code)
  end
end
