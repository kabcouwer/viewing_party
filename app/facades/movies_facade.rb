class MoviesFacade
  def self.top_rated #returns array of movie objects
    response_data = MovieService.top_rated_movies
    x = response_data.map { |data| Movie.new(data) }
  end
end
