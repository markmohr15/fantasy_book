class WagersController < ApplicationController
  layout "application"

  def create_multiple
    params[:wager].each do |attr|
      wager = Wager.new(attr)
      wager.user_id = current_user.id
      wager.save
    end

    redirect_to root_path
  end

  private

  def wager_params
    params.require(:wager).permit(:prop_id, :prop_choice_id, :risk, :odds_juice, :spread_line, :total)
  end

end
