class MovieService
  def self.conn
    Faraday.new(url: 'https://api.themoviedb.org') do |req|
      req.params['api_key'] = ENV['movie_api_key']
    end
  end

  def self.top_rated_movies
    response = conn.get("/3/movie/top_rated")
    body = JSON.parse(response.body, symbolize_name: true)
  end
end
