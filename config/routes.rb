Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :users, :skip => [:sessions, :registrations]
  as :user do
    get "signin", to: "devise/sessions#new", as: :new_user_session
    post "signin", to: "devise/sessions#create", as: :user_session
    delete "signout", to: "devise/sessions#destroy", as: :destroy_user_session
    get "signup", to: "devise/registrations#new", as: :new_user_registration
    get "my_account/account_details", to: "devise/registrations#edit", as: :edit_user_registration
    post "users", to: "devise/registrations#create", as: :user_registration
    patch "users", to: "devise/registrations#update"
    put "users", to: "devise/registrations#update"
    get "my_account/account_details", to: "devise/registrations#edit", as: :user_root
  end

  get "/contact_us", to: "pages#contact"
  get "/privacy_policy", to: "pages#privacy"
  get "/rules", to: "pages#rules"
  get "/my_account/deposit", to: "account#deposit"
  get "/my_account/withdraw", to: "account#withdraw"
  get "/my_account/transfer", to: "account#transfer"
  post "transfers", to: "account#create_transfer"
  get "/my_account/balance", to: "account#balance"
  get "/my_account/challenge", to: "account#challenge"
  get "/my_account/social_media", to: "account#social"
  get "/my_fantasy/my_action", to: "fantasy#my_action"
  get "/my_fantasy/my_history", to: "fantasy#my_history"
  get "/my_fantasy/my_stats", to: "fantasy#my_stats"
  get "/my_fantasy/leaderboard", to: "fantasy#leaderboard"
  resources :props, only: [:index]
  post "wagers", to: "props#create_multiple", as: :wagers

  root to: "props#index"
end

