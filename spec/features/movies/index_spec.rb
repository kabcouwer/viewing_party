require 'rails_helper'

RSpec.describe "Movies Index Page" do
  describe 'authorization' do
    it 'does not allow access for this page if not logged in' do
      visit movies_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Sorry this page is off limits. Please register or login to have access.')
    end
  end

  describe "top rated movies" do
    before :each do
      @user = create(:user)
    end

    it 'displays the top 40 movies' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      VCR.use_cassette('top_rated_movies') do
        visit movies_path

        expect(current_path).to eq movies_path
        expect(page).to have_content('Evangelion: 3.0+1.0 Thrice Upon a Time Vote Average: 8.7') #page 1 results
        expect(page).to have_content("One Flew Over the Cuckoo's Nest Vote Average: 8.4") #page 2 results
      end
    end

    it 'links to each movie show page' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      VCR.use_cassette('top_rated_movies') do
        visit movies_path

        expect(page).to have_link('The Dark Knight')
        expect(page).to have_link("One Flew Over the Cuckoo's Nest")
      end
    end

    it "has a button to discover top 40 movies" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      VCR.use_cassette('top_rated_movies') do
        visit movies_path

        expect(page).to have_button('Find Top Rated Movies')
      end
    end
  end

  describe 'movie search' do
    before :each do
      @user = create(:user)
    end

    it 'can search for a movie by title' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      
      VCR.use_cassette('movie_search') do

        visit movies_path

        fill_in :movie_search, with: 'Earth'

        click_button('Find Movies')

        expect(page).to have_content('22 vs. Earth')
        expect(page).to have_content('Earth Girls Are Easy')
        expect(page).to have_content('Collision Earth')
        expect(page).to have_content('The Day the Earth Stood Still')
      end
    end
  end
end
