class UsersController < ApplicationController

  before_action :ensure_logged_in, only: [:new] 
  
  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      session[:session_token] = @user.reset_session_token!
      login_user!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end

  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end