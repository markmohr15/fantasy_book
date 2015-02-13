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
      start_date = start_params[6..9] + start_params[5] + start_params[0..2] + start_params[3..4] + " 00:00:00"
      ending_date = ending_params[6..9] + ending_params[5] + ending_params[0..2] + ending_params[3..4] + " 23:59:59"
    else
      start_date = Date.today.beginning_of_week(:monday)
      ending_date = Time.now
    end
    @wagers = Wager.joins(:prop).where('props.time' => start_date..ending_date,
      'state' => 1..3, 'user_id' => current_user.id)
  end

  def my_stats
    render
  end

  def leaderboard
    render
  end

end
