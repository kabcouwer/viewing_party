require 'rails_helper'

RSpec.describe "Movies Show Page" do
  before :each do
    @user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit movie_path(1634)
  end

  describe "happy paths" do
    it 'shows the movie title' do
      expect(page).to have_content('Free Willy')
    end
  end
end
