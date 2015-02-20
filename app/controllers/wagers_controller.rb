class WagersController < ApplicationController
  layout "application"
  before_action :user_required

  def create_multiple
    params[:wager].each do |attr|
      unless attr["prop_id"] == ""
        wager = Wager.new(attr.to_hash)
        wager.user_id = current_user.id
        wager.save
      end
    end
    redirect_to :back
  end

  private

  def wager_params
    params.require(:wager).permit(:prop_id, :prop_choice_id, :risk_dollars, :odds, :spread, :total)
  end

end
