require 'rails_helper'

RSpec.describe "Movies Show Page" do
  before :each do
    @user = create(:user)
    @movie_id = movie_id = 329
  end

  describe 'authorization' do
    it 'does not allow access for this page if not logged in' do
      visit movies_path(@movie_id)

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Sorry this page is off limits. Please register or login to have access.')
    end
  end

  describe "happy paths" do
    it 'shows the movie details' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      VCR.use_cassette('find_jurassic_park_details') do
        visit movie_path(@movie_id)

        movie = MovieFacade.find_movie(@movie_id)

        expect(page).to have_content(movie.title)
        expect(page).to have_content("Vote Average: #{movie.rating}")
        expect(page).to have_content("Runtime: #{movie.runtime}")
        expect(page).to have_content("Genre(s): #{movie.genres}")
        expect(page).to have_content("Summary")
        expect(page).to have_content(movie.summary)
        expect(page).to have_content("Cast")
        expect(page).to have_content(movie.cast.first)
        expect(page).to have_content(movie.cast.last)
        expect(page).to have_content("#{movie.reviews.count} Reviews")
        expect(page).to have_content(movie.reviews.first[:author])
        expect(page).to have_content(movie.reviews.first[:comment])
        expect(page).to have_content(movie.reviews.last[:author])
        # expect(page).to have_content(movie.reviews.last[:comment])
      end
    end
  end
end
