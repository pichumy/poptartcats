class UsersController < ApplicationController


  def new

    if logged_in?
      redirect_to cats_url
    else
      @user = User.new
      render :new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to cats_url
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
