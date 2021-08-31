class MovieService
  def self.top_rated_movies(page)
    response = conn.get("/3/movie/top_rated?&page=#{page}")
    body = parse_json(response)
    body[:results]
  end

  def self.find_movie(movie_id)
    response = conn.get("/3/movie/#{movie_id}?")
    parse_json(response)
  end

  def self.find_movie_cast(movie_id)
    response = conn.get("/3/movie/#{movie_id}/credits?")
    parse_json(response)
  end

  def self.find_movie_reviews(movie_id)
    response = conn.get("/3/movie/#{movie_id}/reviews?")
    response_body = parse_json(response)
    response_body[:results]
  end

  def self.movie_search(query, page)
    response = conn.get("/3/search/movie?query=#{query}&page=#{page}")
    body = parse_json(response)
    body[:results]
  end

  def self.conn
    Faraday.new(url: 'https://api.themoviedb.org') do |req|
      req.params['api_key'] = ENV['movie_api_key']
    end
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
