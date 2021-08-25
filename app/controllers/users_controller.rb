class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = user_params
    user[:username] = user[:username].downcase
    new_user = User.create(user)
    flash[:success] = "Weclome, #{new_user.username}"
    redirect_to dashboard_path
  end

  def login
    redirect_to root_path
  end

  def dashboard
    
  end

  private
  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end
