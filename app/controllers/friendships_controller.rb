class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    friend = User.find_by(email: params[:email].downcase)
    friendship = Friendship.create(user: current_user, friend: friend)
    if friendship.save
      redirect_to dashboard_path
    else
      flash[:error] = 'Sorry, your friend cannot be found'
      redirect_to dashboard_path
    end
  end
end
