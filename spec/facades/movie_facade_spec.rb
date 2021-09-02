require 'rails_helper'

RSpec.describe 'MoviesFacade' do
  it 'returns array of Movie objects for top 40 rated movie search' do
    VCR.use_cassette('top_rated_movies') do
      response = MovieFacade.top_rated
      id1 = 19404
      title1 = 'Dilwale Dulhania Le Jayenge'
      rating1 = 8.8
      title2 = "Fight Club"

      expect(response).to be_an(Array)
      expect(response.first).to be_a(Movie)
      expect(response.count).to eq(40)
      expect(response.first.id).to eq(id1)
      expect(response.first.title).to eq(title1)
      expect(response.first.rating).to eq(rating1)
      expect(response.last.title).to eq(title2)
    end
  end

  it 'returns array of searched movies for a query' do
    VCR.use_cassette('movie_search') do
      query = 'Earth'
      response = MovieFacade.movie_search(query)
      id1 = 811367
      rating1 = 7.2
      title1 = '22 vs. Earth'
      title2 = "Daleks' Invasion Earth: 2150 A.D."

      expect(response).to be_an(Array)
      expect(response.count).to eq(40)
      expect(response.first).to be_a(Movie)
      expect(response.first.id).to eq(id1)
      expect(response.first.title).to eq(title1)
      expect(response.first.rating).to eq(rating1)
      expect(response.last.title).to eq(title2)
    end
  end

  it 'returns one movie with very specific search' do
    VCR.use_cassette('specific_movie_search') do
      query = 'Codependent Lesbian Space Alien Seeks Same'
      response = MovieFacade.movie_search(query)
      id = 105538
      rating = 4.8

      expect(response).to be_an(Array)
      expect(response.count).to eq(1)
      expect(response.first).to be_a(Movie)
      expect(response.first.id).to eq(id)
      expect(response.first.title).to eq(query)
      expect(response.first.rating).to eq(rating)
    end
  end

  it 'finds movie details with movie id' do
    VCR.use_cassette('find_jurassic_park_details') do
      movie_id = 329
      response = MovieFacade.find_movie(movie_id)
      title = 'Jurassic Park'
      rating = 7.9
      runtime = 127

      expect(response).to be_a(MovieDetail)
      expect(response).to be_a(Movie)
      expect(response.id).to eq(movie_id)
      expect(response.title).to eq(title)
      expect(response.rating).to eq(rating)
      expect(response.runtime).to eq(runtime)
      expect(response.summary).to be_a(String)
      expect(response.genre_array).to be_an(Array)
      expect(response.genre_array.first).to be_a(Hash)
      expect(response.cast_array).to be_a(Array)
      expect(response.review_array).to be_a(Array)
    end
  end

  it 'finds movie cast with movie id' do
    VCR.use_cassette('find_jurassic_park_cast') do
      movie_id = 329
      response = MovieFacade.find_movie_cast(movie_id)
      name1 = 'Sam Neill'
      character1 = 'Dr. Alan Grant'
      name2 = 'Samuel L. Jackson'
      character2 = 'Arnold'

      expect(response).to be_an(Array)
      expect(response.count).to eq(10)
      expect(response.first).to be_a(Hash)
      expect(response.first[:name]).to eq(name1)
      expect(response.first[:character]).to eq(character1)
      expect(response.last[:name]).to eq(name2)
      expect(response.last[:character]).to eq(character2)
    end
  end

  it 'finds movie reviews with movie id' do
    VCR.use_cassette('find_jurassic_park_reviews') do
      movie_id = 329
      response = MovieFacade.find_movie_reviews(movie_id)
      username1 = 'BinaryCrunch'
      username2 = 'nsinger99'

      expect(response).to be_an(Array)
      expect(response.first).to be_a(Hash)
      expect(response.first[:author_details][:username]).to eq(username1)
      expect(response.first[:content]).to be_a(String)
      expect(response.last[:author_details][:username]).to eq(username2)
      expect(response.last[:content]).to be_a(String)
    end
  end
end
