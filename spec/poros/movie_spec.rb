require 'rails_helper'

RSpec.describe Movie do
  before :each do
    json = File.read('./spec/fixtures/free_willy.json')
    movie_data = JSON.parse(json, symbolize_names: true)
    data = movie_data[:results].first
    @movie = Movie.new(data)
  end

  it 'has movie info' do
    expect(@movie.id).to eq(1634)
    expect(@movie.title).to eq('Free Willy')
    expect(@movie.rating).to eq(6.2)
  end
end
 
