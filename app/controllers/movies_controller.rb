class MoviesController < ApplicationController
  before_action :require_login, only: %i[index show]

  def index
    if params[:movie_search]
      query = params[:movie_search]
      @movie_search = MovieFacade.movie_search(query, 2)
    else
      @top_rated = MovieFacade.top_rated(2)
    end
  end

  def show
    @movie = MovieFacade.find_movie(params[:id])
  end
end
