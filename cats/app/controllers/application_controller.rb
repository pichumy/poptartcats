class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def login(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
    Session.create!(user_id: @current_user.id, session_token: @current_user.session_token, ip_address: request.remote_ip)
  end

  def logout
    Session.delete(current_user.id, session[:session_token])
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.joins(:sessions).where('sessions.session_token = ?', session[:session_token]).first
  end

  def logged_in?
    !!current_user
  end

  def require_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def require_log_out
    redirect_to cats_url if logged_in?
  end

end
