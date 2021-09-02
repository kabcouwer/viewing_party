class DashboardController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    @friends = current_user.friends if current_user
  end
end
