require 'rails_helper'

RSpec.describe "Discover Page" do
  describe "Top rated movies and search by title" do
    before :each do
      WebMock.allow_net_connect! #not sure this is ideal

      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit discover_path
    end

    it 'displays button to find top rated 40 movies' do
      expect(page).to have_button('Find Top Rated Movies')

      click_on "Find Top Rated Movies"

      expect(current_path).to eq(movies_path)
    end

    it 'redirects to the movies index when a title is submitted to the movie search' do
      expect(page).to have_content('Search by movie title:')

      fill_in :movie_search, with: 'Kim and Jo Dominate Mod 3'

      click_button('Find Movies')

      expect(current_path).to eq(movies_path)
    end
  end
end
#
# As an authenticated user,
# When I visit the '/discover' path
# I should see
#
#  Button to Discover top 40 movies
# Details When the user clicks on the top 40 button they should be taken to the movies page.
#
#  A text field to enter keyword(s) to search by movie title
#  A Button to Search by Movie Title
# Details When the user clicks on the Search button they should be taken to the movies page
#
# The movies will be retrieved by consuming The MovieDB API
