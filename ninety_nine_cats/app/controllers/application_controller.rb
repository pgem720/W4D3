class ApplicationController < ActionController::Base
  helper_method :current_user
  
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!(user)
    # user.class.find_by_credentials(username:, password)
    session[:session_token] = user.reset_session_token!
    redirect_to cats_url
  end

  # def ensure_logged_out
  #   redirect_to cats_url if !logged_in?
  # end

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def logged_in?
    !!current_user
  end

end
