class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource

  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == 'edit'
      "account"
    else
      "application"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :name, :address, :city, :state, :zip, :country, :phone, :referral_code) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password,
     :password_confirmation, :name, :address, :city, :state, :zip,
     :country, :phone, :email_notif, :sms_notif, :current_password) }
  end

  def after_sign_in_path_for(resource)
    if current_user.role == "admin" || current_user.role == "superadmin"
      admin_root_path
    else
      root_path
    end
  end

  def user_required
    if current_user
    else
      redirect_to new_user_session_path
    end
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  def unauthorized
    redirect_to root_url, alert: t("sessions.unauthorized")
  end
end
