require 'rails_helper'

RSpec.describe "New Viewing Party" do
  describe "Create new party with party logistics and invite friends" do
    before :each do
      @user1 = create(:user)
      # @user2 = create(:user)
      # @user3 = create(:user)
      # @user4 = create(:user)

      @user2 = User.create!(email: 'test1@email.com', username: 'Tester1', password: 'hocuspocus1')
      @user3 = User.create!(email: 'test2@email.com', username: 'Tester2', password: 'hocuspocus2')
      @user4 = User.create!(email: 'test3@email.com', username: 'Tester3', password: 'hocuspocus3')

      @friendship1 = create(:friendship, user: @user1, friend: @user2)
      @friendship2 = create(:friendship, user: @user1, friend: @user3)
      @friendship3 = create(:friendship, user: @user1, friend: @user4)

      @movie_id = 329
    end

    describe 'authorization' do
      it 'does not allow access for this page if not logged in' do
        visit movie_path(@movie_id)

        expect(current_path).to eq(root_path)
        expect(page).to have_content('Sorry this page is off limits. Please register or login to have access.')
      end
    end

    it 'dislays a form to create a party to view selected movie' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      VCR.use_cassette('find_jurassic_park_details') do
        visit movie_path(@movie_id)

        movie = MovieFacade.find_movie(@movie_id)

        click_link('Create Viewing Party for Jurassic Park')

        expect(current_path).to eq(new_party_path)
        expect(page).to have_field('party[movie_title]', with: 'Jurassic Park')
        expect(page).to have_field('party[duration]', with: 127)
        expect(page).to have_field('party[day]')
        expect(page).to have_field('party[start_time]')

        fill_in 'party[day]', with: '2021/10/10'
        fill_in 'party[start_time]', with: '07:00 PM'

        within "#friend-#{@user2.id}" do
          check("party[attendees[#{@user2.id}]]")
        end

        within "#friend-#{@user3.id}" do
          check("party[attendees[#{@user3.id}]]")
        end

        within "#friend-#{@user4.id}" do
          check("party[attendees[#{@user4.id}]]")
        end
        
        expect(page).to have_button('Create Party')

        click_on('Create Party')

        expect(current_path).to eq(dashboard_path)
      end
    end
  end
end
