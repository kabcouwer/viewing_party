require 'rails_helper'

RSpec.describe "New Viewing Party" do
  describe "Create new party with party logistics and invite friends" do
    before :each do
      @user1 = create(:user)
      @user2 = create(:user)
      @user3 = create(:user)
      @user4 = create(:user)

      @friendship1 = create(:friendship, user: @user1, friend: @user2)
      @friendship2 = create(:friendship, user: @user1, friend: @user3)
      @friendship3 = create(:friendship, user: @user1, friend: @user4)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      #see what stub or vcr info kim used for moveie show page; ideally use same here
      # free_willy_stub
    end

    xit 'dislays the title of movie selected' do
      VCR.use_cassette('find_jurassic_park_details') do
        movie_id = 329
        visit movie_path(movie_id)

        click_button('Create Viewing Party for Movie')

        expect(current_path).to eq(new_party_path)
        expect(page).to have_content('Jurassic Park')
      end
    end

    it 'dislays a form to create a party to view selected movie' do
      VCR.use_cassette('find_jurassic_park_details') do
        movie_id = 329
        visit movie_path(movie_id)

        click_button('Create Viewing Party for Movie')

        expect(page).to have_field(:duration, with: 90) #change t relevant stub info
        expect(page).to have_field(:day)
        expect(page).to eq(:start_time)
        expect(page).to to_have_unchecked_field("#{@user.friends.first.username}")

        within("#friend-#{@friend.id}") do
          check "#{@friend.username}"
        end

        fill_in :date, with: '2021-10-10'
        fill_in :start_time, with: '07:00 PM'
        click_button('Create Party')

        expect(current_path).to eq(dashboard_path)
      end
    end
  end
end
