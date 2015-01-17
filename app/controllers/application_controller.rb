class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :name, :address, :city, :state, :zip, :country, :phone) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password,
     :password_confirmation, :name, :address, :city, :state, :zip, :country, :phone, :current_password) }
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
