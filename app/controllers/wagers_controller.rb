class WagersController < ApplicationController
  layout "application"
  before_action :user_required

  def create
    if current_user.valid_password?(params[:password])
      @wagers = params[:wager].map { |attrs| Wager.create(attrs.to_hash.merge(user_id: current_user.id)) unless attrs["prop_id"] == "" }
      @wagers = @wagers[0...-1]
      PropMailer.test_email(current_user).deliver_later
    else
      @password_error = "Invalid Password"
    end
    respond_to do |format|
      format.html
      format.js
    end

  end

  private

  def wager_params
    params.require(:wager).permit(:prop_id, :prop_choice_id, :risk_dollars, :odds, :spread, :total)
  end

end
