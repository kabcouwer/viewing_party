class MovieFacade
  def self.top_rated(pages = 2)
    response = (1..pages).sum do |i|
      MovieService.top_rated_movies(i)
    end
    create_movie_objects(response)
  end

  def self.movie_search(query, pages = 2)
    response = (1..pages).sum do |i|
      MovieService.movie_search(query, i)
    end
    create_movie_objects(response)
  end

  def self.find_movie(movie_id)
    response = MovieService.find_movie(movie_id)
    create_detailed_movie_object(response)
  end

  def self.find_movie_cast(movie_id, cast_number = 10)
    response = MovieService.find_movie_cast(movie_id)
    response[:cast][0..(cast_number - 1)]
  end

  def self.find_movie_reviews(movie_id)
    response = MovieService.find_movie_reviews(movie_id)
  end

  def self.create_movie_objects(response)
    response.map { |data| Movie.new(data) }
  end

  def self.create_detailed_movie_object(response)
    movie_id = response[:id]
    response[:cast] = find_movie_cast(movie_id)
    response[:reviews] = find_movie_reviews(movie_id)
    new_movie = MovieDetail.new(response)
  end
end
