require 'rails_helper'

RSpec.describe MovieDetail do
  it 'has movie info' do
    json = File.read('./spec/fixtures/find_jurassic_park_details.json')
    movie_data = JSON.parse(json, symbolize_names: true)
    movie = MovieDetail.new(movie_data)

    expect(movie.id).to eq(329)
    expect(movie.title).to eq('Jurassic Park')
    expect(movie.rating).to eq(7.9)
    expect(movie.runtime).to eq(127)
    expect(movie.genre_array).to be_an(Array)
    expect(movie.genres).to eq('Adventure, Science Fiction')
    expect(movie.summary).to be_a(String)
  end

  it 'can form #cast' do
    VCR.use_cassette('find_jurassic_park_details') do
      movie_id = 329
      movie = MovieFacade.find_movie(movie_id)
      cast1 = 'Sam Neill as Dr. Alan Grant'
      cast2 = 'Samuel L. Jackson as Arnold'

      expect(movie.cast).to be_an(Array)
      expect(movie.cast.first).to eq(cast1)
      expect(movie.cast.last).to eq(cast2)
    end
  end

  it 'can form #reviews' do
    VCR.use_cassette('find_jurassic_park_details') do
      movie_id = 329
      movie = MovieFacade.find_movie(movie_id)
      username1 = 'BinaryCrunch'
      username2 = 'nsinger99'

      expect(movie.reviews).to be_an(Array)
      expect(movie.reviews.first[:author]).to eq(username1)
      expect(movie.reviews.first[:comment]).to be_a(String)
      expect(movie.reviews.last[:author]).to eq(username2)
      expect(movie.reviews.last[:comment]).to be_a(String)
    end
  end
end
