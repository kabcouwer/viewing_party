require 'rails_helper'

RSpec.describe 'MoviesFacade' do
  it 'returns array of Movie objects for top 40 rated movie search' do
    VCR.use_cassette('top_rated_movies') do

      top_rated = MoviesFacade.top_rated

      expect(top_rated).to be_an(Array)
      expect(top_rated.first).to be_a(Movie)
      expect(top_rated.count).to eq(40)
    end
  end

  it 'returns array of searched movies for a query' do
    VCR.use_cassette('movie_search') do

      query = 'Earth'

      movie_search = MoviesFacade.movie_search(query)

      expect(movie_search).to be_an(Array)
      expect(movie_search.count).to eq(40)
      expect(movie_search.first).to be_a(Movie)
      expect(movie_search.first.title).to eq('22 vs. Earth')
      expect(movie_search.last.title).to eq('The Year Earth Changed')
    end
  end

  it 'returns one movie with very specific search' do
    VCR.use_cassette('specific_movie_search') do
      query = 'Codependent Lesbian Space Alien Seeks Same'

      movie_search = MoviesFacade.movie_search(query)

      expect(movie_search).to be_an(Array)
      expect(movie_search.count).to eq(1)
      expect(movie_search.first).to be_a(Movie)
      expect(movie_search.first.title).to eq(query)
    end
  end
end
