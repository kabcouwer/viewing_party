require 'rails_helper'

RSpec.describe "Movies Index Page" do
  describe "top rated movies" do
    before :each do
      @user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      top_rated_movies_stubs #hidden in spec_helper :)

      visit movies_path
    end

    it 'displays the top 40 movies' do
      expect(current_path).to eq movies_path
      expect(page).to have_content('Evangelion: 3.0+1.0 Thrice Upon a Time Vote Average: 8.8') #page 1 results
      expect(page).to have_content("One Flew Over the Cuckoo's Nest Vote Average: 8.4") #page 2 results
    end

    it 'links to each movie show page' do
      expect(page).to have_link('The Dark Knight')
      expect(page).to have_link("One Flew Over the Cuckoo's Nest")
    end

    it "has a button to discover top 40 movies" do
      expect(page).to have_button('Find Top Rated Movies')
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
