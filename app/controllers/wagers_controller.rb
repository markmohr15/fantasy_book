class WagersController < ApplicationController
  layout "application"

  def create_multiple
    params[:wager].each do |attr|
      wager = Wager.new(attr)
      wager.user_id = current_user.id
      wager.save
    end

  end

  private

  def wager_params
    params.permit(:wager).permit! #(:prop_id, :prop_choice_id, :risk_dollars, :odds, :spread, :total)
  end

end
