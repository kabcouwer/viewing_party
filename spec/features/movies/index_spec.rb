require 'rails_helper'

RSpec.describe "Movies Index Page" do
  describe "top rated movies" do
    before :each do
      @user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      response_body_1 = File.read('spec/fixtures/top_rated_page_1.json')

      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['movie_api_key']}&page=1").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.7.0'
           }).
         to_return(status: 200, body: response_body_1, headers: {})

      response_body_2 = File.read('spec/fixtures/top_rated_page_2.json')

      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['movie_api_key']}&page=2").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.7.0'
           }).
         to_return(status: 200, body: response_body_2, headers: {})

      visit movies_path
    end

    it 'displays the top 40 movies' do
      expect(current_path).to eq movies_path

      expect(page).to have_content('The Shawshank Redemption 8.7')
      # expect(page).to have_content "One Flew Over the Cuckoo's Nest Vote Average: 8.4"
    end

    it "has a link to discover top 40 movies" do
    end

    it 'links to each movie show page' do

    end
  end
  end

  # describe "movie search" do
  #   before :each do
  #     @user = User.create!(email: 'DirtyGertie03@doggo.com', username: 'DirtyGertie03', password: 'RainbowRoll4lyfe')
  #     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  #     visit movies_path #placeholder until routing is determined
  #     #add stub details
  #
  #     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  #
  #     response_body_1 = File.read('spec/fixtures/top_rated_page_1.json')
  #
  #     # allow_any_instance_of(MovieService).to receive(:top_rated_movies).and_return(response_body_1)
  #
  #     stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=fd5e3ca81314005137fc3ebb81c91437&page=1").
  #            to_return(status: 200, body: "", headers: {})
  #   end
  #
  #   it 'can search for a movie by title' do
  #   end
  #
  #   it 'only displays first 40 search results' do
  #   end
  #
  #   it 'links to each movie show page' do
  #   end
  #
  #   #add edge cases (returns no search results, etc.)
  # end

# As an authenticated user,
# When I visit the movies page,
# I should see the 40 results from my search,
# I should also see the "Find Top Rated Movies" button and the Find Movies form at the top of the page.
#
# Details: The results from the search should appear on this page, and there should only be a maximum of 40 results. The following details should be listed for each movie.
#
#  Title (As a Link to the Movie Details page)
#  Vote Average of the movie
