require 'rails_helper'

describe MovieService do
  describe "#top rated movies" do
    it 'displays data for top 40 rated movies' do
      top_rated_movies_stubs

      response = MovieService.top_rated_movies.first
      title = "Evangelion: 3.0+1.0 Thrice Upon a Time"

      expect(response).to be_a(Hash)
      expect(response[:title]).to eq(title)
      expect(response[:vote_average]).to eq(8.8)
    end
  end
end
