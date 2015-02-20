class WagersController < ApplicationController
  layout "application"
  before_action :user_required

  def create_multiple
    params[:wager].each do |attr|
      wager_params = attr
      wager = Wager.new(wager_params)
      wager.user_id = current_user.id
      wager.save
    end
  end

  private

  def wager_params
    params.require(:wager).permit(:prop_id, :prop_choice_id, :risk_dollars, :odds, :spread, :total)
  end

end
