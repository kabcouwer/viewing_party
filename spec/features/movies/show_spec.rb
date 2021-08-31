require 'rails_helper'

RSpec.describe "Movies Show Page" do
  before :each do
    @user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    @movie_id = movie_id = 329
  end

  describe "happy paths" do
    it 'shows the movie title' do
      VCR.use_cassette('find_jurassic_park_details') do
        visit movie_path(@movie_id)

        movie = MovieFacade.find_movie(@movie_id)

# save_and_open_page
        expect(page).to have_content(movie.title)
        expect(page).to have_content("Vote Average: #{movie.rating}")
        expect(page).to have_content("Runtime: #{movie.runtime}")
        expect(page).to have_content("Genre(s): #{movie.genres}")
        expect(page).to have_content("Summary:")
        expect(page).to have_content(movie.summary)
        expect(page).to have_content("Cast:")
        expect(page).to have_content(movie.cast.first)
        expect(page).to have_content(movie.cast.last)
      end
    end
  end
end
