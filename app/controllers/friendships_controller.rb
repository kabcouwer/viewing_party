class FriendshipsController < ApplicationController
  def new
    # @friendship = Friendship.new
  end

  def create
    friend = User.find_by(email: params[:email].downcase)
    friendship = Friendship.create(user: current_user, friend: friend)
    flash[:error] = 'Sorry, your friend cannot be found' unless friendship.save
    redirect_to dashboard_path
  end
end
