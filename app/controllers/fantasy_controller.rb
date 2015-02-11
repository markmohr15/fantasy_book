class FantasyController < ApplicationController
  layout "fantasy"

  def my_action
    @wagers = Wager.where(user_id: current_user.id, state: 0)
    @risk_counter = 0
    @win_counter = 0
  end

  def my_history
    if params[:beg_date].present?
      start_params = params[:beg_date]
      ending_params = params[:end_date]
      start_date = DateTime.new(start_params["year"].to_i, start_params["month"].to_i, start_params["day"].to_i)
      ending_date = DateTime.new(ending_params["year"].to_i, ending_params["month"].to_i, ending_params["day"].to_i)
      @wagers = Wager.joins(:prop).where('props.time' => start_date..ending_date,
      'state' => 1..3, 'user_id' => current_user.id)
    else
      @wagers = Wager.where(state: 1..3, user_id: current_user.id)
    end
  end

  def my_stats
    render
  end

  def leaderboard
    render
  end

end
