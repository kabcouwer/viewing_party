class DiscoverController < ApplicationController
  before_action :require_login, only: [:index]

  def index; end
end
