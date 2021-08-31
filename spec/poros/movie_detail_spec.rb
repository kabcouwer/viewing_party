require 'rails_helper'

RSpec.describe MovieDetail do
  before :each do
    json = File.read('./spec/fixtures/find_jurassic_park_details.json')
    movie_data = JSON.parse(json, symbolize_names: true)
    @movie = MovieDetail.new(movie_data)
  end

  it 'has movie info' do
    expect(@movie.id).to eq(329)
    expect(@movie.title).to eq('Jurassic Park')
    expect(@movie.rating).to eq(7.9)
    expect(@movie.runtime).to eq(127)
    expect(@movie.genre_array).to be_an(Array)
    expect(@movie.genres).to eq('Adventure, Science Fiction')
    expect(@movie.summary).to be_a(String)
  end
end
