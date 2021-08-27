class MoviesController < ApplicationController
  def index
    @top_rated = MoviesFacade.top_rated
  end

  def show
  end
end
