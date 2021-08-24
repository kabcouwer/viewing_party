class UsersController < ApplicationController
  def new

  end

  def login
    redirect_to root_path
  end
end
