class SessionsController < ApplicationController
  def new

  end

  def create
    found_user = User.find_by(email: params[:email].downcase)
    if found_user && found_user.authenticate(params[:password])
      session[:user_id] = found_user.id
      flash[:success] = "Welcome, #{found_user.username}!"
      redirect_to dashboard_path
    else
      flash[:error] = 'Sorry, your credentials are invalid. Try Again.'
      render :new
    end
  end

  # def destroy
  #   session[:user_id] = nil
  #   redirect_to root_path
  # end
end
