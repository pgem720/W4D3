class SessionsController < ApplicationController

  # before_action :ensure_logged_out, only: [:new] 
  def new
    if logged_in?
      flash.now[:errors] = ["Already signed in!"]
      render :new
    else
      render :new
    end
  end


  def create
    debugger
    user = User.find_by_credentials(username, password)
    if user
    login_user!(user)
    else
      flash.now[:errors] = user.errors.full_message
    end
  end

  def destroy!
    session[:session_token] = nil
    current_user.reset_session_token!
    redirect_to cats_url
  end
end