require 'rails_helper'

describe MovieService do
  describe '#top rated movies' do
    it 'displays data for top 40 rated movies' do
      top_rated_movies_stubs

      response = MovieService.top_rated_movies
      title = 'Evangelion: 3.0+1.0 Thrice Upon a Time'

      expect(response).to be_an(Array)
      expect(response.first).to be_a(Hash)
      expect(response.first[:title]).to eq(title)
      expect(response.first[:vote_average]).to eq(8.8)
      expect(response.count).to eq(40)
    end
  end
end

#confirm whether or not we need to test the helper methods
