class UsersController < ApplicationController
  before_action :new_user, only: [:create]

  def new
    @user = User.new
  end

  def create
    if new_user.save
      flash[:success] = "Welcome, #{new_user.username}"
      redirect_to dashboard_path
    else
      flash[:error] = new_user.errors.full_messages.to_sentence
      redirect_to registration_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end

  def new_user
    user = user_params
    user[:username] = user[:username].downcase
    user[:email] = user[:email].downcase
    User.create(user)
  end
end
