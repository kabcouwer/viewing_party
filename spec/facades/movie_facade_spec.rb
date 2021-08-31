require 'rails_helper'

RSpec.describe 'MoviesFacade' do
  it 'returns array of Movie objects for top 40 rated movie search' do
    VCR.use_cassette('top_rated_movies') do
      response = MovieFacade.top_rated(2)
      id1 = 19404
      title1 = 'Dilwale Dulhania Le Jayenge'
      rating1 = 8.8
      title2 = "One Flew Over the Cuckoo's Nest"

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
      response = MovieFacade.movie_search(query, 2)
      id1 = 811367
      rating1 = 7.2
      title1 = '22 vs. Earth'
      title2 = 'Asteroid vs Earth'

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

  it 'finds movie with movie id' do
    VCR.use_cassette('find_free_willy_details') do
      movie_id = 1634
      response = MovieFacade.find_movie(movie_id)
      title = 'Free Willy'
      rating = 6.2
      runtime = 112
      genres = 'Family, Adventure, Drama'

      expect(response).to be_a(MovieDetail)
      expect(response).to be_a(Movie)
      expect(response.id).to eq(movie_id)
      expect(response.title).to eq(title)
      expect(response.rating).to eq(rating)
      expect(response.runtime).to eq(runtime)
      expect(response.genre_array).to be_an(Array)
      expect(response.genres).to eq(genres)
      expect(response.summary).to be_a(String)
    end
  end

  it 'finds movie cast with movie id' do
    VCR.use_cassette('find_jurassic_park_cast') do
      movie_id = 329
      response = MovieFacade.find_movie_cast(movie_id)
      title = 'Jurassic Park'
      cast1 = 'Sam Neill as Dr. Alan Grant'
      cast2 = 'Samuel L. Jackson as Arnold'

      expect(response).to be_an(Array)
      expect(response.count).to eq(10)
      expect(response.first).to eq(cast1)
      expect(response.last).to eq(cast2)
    end
  end

  it 'adds cast to movie detail' do
    VCR.use_cassette('find_free_willy_details') do
      movie_id = 1634
      response = MovieFacade.find_movie(movie_id)

      expect(response).to be_a(MovieDetail)
      expect(response).to be_a(Movie)
      expect(response.cast).to be_an(Array)
      expect(response.cast.count).to eq(10)
      expect(response.cast.first).to eq('Jason James Richter as Jesse')
      expect(response.cast.last).to eq('Danielle Harris as Gwenie')
    end
  end

  it 'finds movie cast with movie id' do
    VCR.use_cassette('find_jurassic_park_reviews') do
      movie_id = 329
      response = MovieFacade.find_movie_reviews(movie_id)

      expect(response).to be_an(Array)
      expect(response.first).to be_a(Hash)
      expect(response.first[:author]).to eq('BinaryCrunch')
      expect(response.first[:comment]).to be_a(String)
    end
  end

  it 'adds reviews to movie detail' do
    VCR.use_cassette('find_jurassic_park_details') do
      movie_id = 329
      response = MovieFacade.find_movie(movie_id)

      expect(response).to be_a(MovieDetail)
      expect(response).to be_a(Movie)
      expect(response.reviews).to be_an(Array)
      expect(response.reviews.first).to be_a(Hash)
      expect(response.reviews.first[:author]).to eq('BinaryCrunch')
      expect(response.reviews.first[:comment]).to be_a(String)
    end
  end
end
