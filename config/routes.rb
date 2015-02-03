Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :users

  get "/contact_us", to: "pages#contact"
  get "/privacy_policy", to: "pages#privacy"
  get "/rules", to: "pages#rules"
  get "/my_account/deposit", to: "account#deposit"
  get "/my_account/withdraw", to: "account#withdraw"
  get "/my_account/transfer", to: "account#transfer"

  root to: "pages#home"
end
