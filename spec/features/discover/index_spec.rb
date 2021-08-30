require 'rails_helper'

RSpec.describe "Discover Page" do
  describe "Top rated movies and search by title" do
    before :each do
      @user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit discover_path
    end

    it 'displays button to find top rated 40 movies' do
      VCR.use_cassette('top_rated_movies') do

        expect(page).to have_button('Find Top Rated Movies')

        click_on "Find Top Rated Movies"

        expect(current_path).to eq(movies_path)
      end
    end

    it 'redirects to the movies index when a title is submitted to the movie search' do
      VCR.use_cassette('specific_movie_search') do
        expect(page).to have_content('Search by movie title:')

        fill_in :movie_search, with: 'Codependent Lesbian Space Alien Seeks Same'

        click_button('Find Movies')

        expect(current_path).to eq(movies_path)
      end
    end
  end
end
