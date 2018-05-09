class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to cats_url
    else
      @user = User.new
      render :new
    end
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if @user
      login(@user)
      redirect_to cats_url
    else
      flash[:error] = "Username and password don't match"
      redirect_to new_session_url
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end
end
