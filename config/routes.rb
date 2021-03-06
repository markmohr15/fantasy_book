Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :users, skip: [:sessions, :registrations], controllers: {passwords: "passwords"}
  as :user do
    get "signin", to: "sessions#new", as: :new_user_session
    post "signin", to: "devise/sessions#create", as: :user_session
    delete "signout", to: "devise/sessions#destroy", as: :destroy_user_session
    get "signup", to: "registrations#new", as: :new_user_registration
    get "my_account/account_details", to: "devise/registrations#edit", as: :edit_user_registration
    post "users", to: "devise/registrations#create", as: :user_registration
    patch "users", to: "devise/registrations#update"
    put "users", to: "devise/registrations#update"
    get "my_account/account_details", to: "devise/registrations#edit", as: :user_root
  end

  get "/contact_us", to: "pages#contact"
  get "/privacy_policy", to: "pages#privacy"
  get "/rules", to: "pages#rules"
  get "/terms_of_use", to: "pages#terms", as: :terms
  get "/my_account/deposit", to: "account#deposit"
  post "/my_account/deposit", to: "account#charge_card"
  #post "my_account/balance", to: "account#paypal", as: :paypal
  match "/my_account/withdraw", to: "account#withdraw", via: [:get, :post]
  match "/my_account/transfer", to: "account#transfer", via: [:get, :post]
  get "/my_account/balance", to: "account#balance"
  get "/my_account/challenge", to: "account#challenge"
  get "/my_account/bonuses", to: "account#bonuses"
  get "my_account/affiliate", to: "account#affiliate"
  get "/my_fantasy/my_action", to: "fantasy#my_action"
  get "/my_fantasy/my_history", to: "fantasy#my_history"
  get "/my_fantasy/my_stats", to: "fantasy#my_stats"
  get "/my_fantasy/leaderboard", to: "fantasy#leaderboard"
  resources :props
  post "wagers", to: "wagers#create", as: :wagers
  get "pc", to: "props#pc"
  get "prop", to: "props#prop"
  get "bc", to: "account#bc"
  get "balance", to: "application#balance"
  post "/notifications/notify", to: "twilio#notify"

  root to: "props#index"
end

