class MoviesController < ApplicationController
  def index
    if params[:movie_search]
      query = params[:movie_search]
      @movie_search = MoviesFacade.movie_search(query)
    else
      @top_rated = MoviesFacade.top_rated
    end
  end

  def show; end
end
