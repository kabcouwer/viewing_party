class DashboardController < ApplicationController
  def index
    @friends = current_user.friends if current_user
  end
end
