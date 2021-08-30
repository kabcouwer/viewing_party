class MoviesFacade
  def self.top_rated
    # returns array of movie objects
    response_data = MovieService.top_rated_movies
    response_data.map { |data| Movie.new(data) }
  end

  def self.movie_search(query)
    # returns array of movie objects
    response_data = MovieService.movie_search(query)
    response_data.map { |data| Movie.new(data) }
  end
end
