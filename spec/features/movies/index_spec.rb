require 'rails_helper'

RSpec.describe "Movies Index Page" do
  describe "top rated movies" do
    before :each do
      @user = User.create!(email: 'DirtyGertie03@doggo.com', username: 'DirtyGertie03', password: 'RainbowRoll4lyfe')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit movies_path #placeholder until routing is determined

      # add stub details
    end

    it 'displays the top 40 movies' do
    end

    it "has a link to discover top 40 movies" do
    end

    it 'links to each movie show page' do

    end
  end
  end

  describe "movie search" do
    before :each do
      @user = User.create!(email: 'DirtyGertie03@doggo.com', username: 'DirtyGertie03', password: 'RainbowRoll4lyfe')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit movies_path #placeholder until routing is determined
      #add stub details
    end

    it 'can search for a movie by title' do
    end

    it 'only displays first 40 search results' do
    end

    it 'links to each movie show page' do
    end

    #add edge cases (returns no search results, etc.)
  end

# As an authenticated user,
# When I visit the movies page,
# I should see the 40 results from my search,
# I should also see the "Find Top Rated Movies" button and the Find Movies form at the top of the page.
#
# Details: The results from the search should appear on this page, and there should only be a maximum of 40 results. The following details should be listed for each movie.
#
#  Title (As a Link to the Movie Details page)
#  Vote Average of the movie
