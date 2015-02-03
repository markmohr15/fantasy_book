Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :users

  get "/contact_us", to: "pages#contact"
  get "/privacy_policy", to: "pages#privacy"
  get "/rules", to: "pages#rules"
  get "/my_account/deposit", to: "account#deposit"
  get "/my_account/withdraw", to: "account#withdraw"
  get "/my_account/transfer", to: "account#transfer"
  get "/my_fantasy/my_action", to: "fantasy#my_action"
  get "/my_fantasy/my_history", to: "fantasy#my_history"
  get "/my_fantasy/my_stats", to: "fantasy#my_stats"
  get "/my_fantasy/leaderboard", to: "fantasy#leaderboard"

  root to: "pages#home"
end
