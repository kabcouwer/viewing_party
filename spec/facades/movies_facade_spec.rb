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
end
