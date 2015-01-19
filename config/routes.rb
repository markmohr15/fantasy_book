Rails.application.routes.draw do

  devise_for :users

  get "/contact_us", to: "pages#contact"
  get "/privacy_policy", to: "pages#privacy"
  get "/rules", to: "pages#rules"

  root to: "pages#home"
end