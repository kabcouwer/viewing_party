class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

  private

  def require_login
    if current_user.nil?
      flash[:alert] = 'Sorry this page is off limits. Please register or login to have access.'
      redirect_to root_path
    end
  end
end

# @current_user ||= User.find(session[:user_id]) if session[:user_id]
