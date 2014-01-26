class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  # protect_from_forgery with: :exception

  # TODO: START remove these lines after actual validation
  helper_method :current_user, :signed_in?, :admin?

  def is_logged_in?
    return true if params[:uid] and params[:uid] == GlobalConstants::ADMIN
    return false
  end
  # TODO: END remove these lines after actual validation

  protected

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def admin?
    signed_in? && !current_user.email.nil? && GlobalConstants::ADMIN_EMAILS.include?(current_user.email.downcase)
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end
end
