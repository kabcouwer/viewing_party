class MovieService
  #ideally refactor at some point
  def self.top_rated_movies
    page_1_response = conn.get("/3/movie/top_rated?&page=1")
    page_2_response = conn.get("/3/movie/top_rated?&page=2")
    # moving this to a helper method to user with various methods/endpoints
    # body = JSON.parse(response.body, symbolize_name: true)
    page_1_body = parse_json(page_1_response)
    page_2_body = parse_json(page_2_response)

    page_1_body[:results] + page_2_body[:results]
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
