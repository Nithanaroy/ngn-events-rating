class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # TODO: START remove these lines after actual validation
  before_filter :is_logged_in?
  helper_method :is_logged_in?

  def is_logged_in?
    return true if params[:uid] and params[:uid] == GlobalConstants::ADMIN
    return false
  end
  # TODO: END remove these lines after actual validation
end
