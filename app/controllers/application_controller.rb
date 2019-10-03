class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  private

  def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  def authorize
  redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user
  end
end
