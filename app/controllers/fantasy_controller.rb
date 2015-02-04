class FantasyController < ApplicationController
  layout "fantasy"

  def my_action
    @wagers = Wager.where(user_id: current_user.id, state: 0)
  end

  def my_history
    render
  end

  def my_stats
    render
  end

  def leaderboard
    render
  end

end
