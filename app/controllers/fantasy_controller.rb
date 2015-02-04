class FantasyController < ApplicationController
  layout "fantasy"

  def my_action
    @wagers = Wager.where(user_id: current_user.id, state: 0)
  end

  def my_history
    @wagers = Wager.where(user_id: current_user.id, state: 1..3)
  end

  def my_stats
    render
  end

  def leaderboard
    render
  end

end
