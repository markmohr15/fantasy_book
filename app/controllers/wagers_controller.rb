class WagersController < ApplicationController
  layout "application"

  def create_multiple
    if current_user
      params[:wager].each do |attr|
        binding.pry
        wager_params = attr
        wager = Wager.new(wager_params)
        wager.user_id = current_user.id
        wager.save
      end
    else
      redirect to new_user_session_path
    end

  end

  private

  def wager_params
    params.require(:wager).permit(:prop_id, :prop_choice_id, :risk_dollars, :odds, :spread, :total)
  end

end
