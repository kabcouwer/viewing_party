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

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    end

    xit 'dislays the title of movie selected' do
      VCR.use_cassette('find_jurassic_park_details') do
        movie_id = 329
        visit movie_path(movie_id)

        movie = MovieFacade.find_movie(movie_id)

        click_link('Create Viewing Party for Jurassic Park')

        expect(current_path).to eq(new_party_path)
        save_and_open_page
        expect(page).to have('Jurassic Park')
      end
    end

    it 'dislays a form to create a party to view selected movie' do
      VCR.use_cassette('find_jurassic_park_details') do
        movie_id = 329

        visit movie_path(movie_id)

        movie = MovieFacade.find_movie(movie_id)

        click_link('Create Viewing Party for Jurassic Park')

        expect(current_path).to eq(new_party_path)
        visit movie_path(movie_id)

        movie = MovieFacade.find_movie(movie_id)

        click_link('Create Viewing Party for Jurassic Park')

        expect(current_path).to eq(new_party_path)


        expect(page).to have_field('party[movie_title]', with: 'Jurassic Park')
        expect(page).to have_field('party[duration]', with: 127)
        expect(page).to have_field('party[day]')
        expect(page).to have_field('party[start_time]')

        #factory_bot struggles
        #   name = @user2.username
        #   clean_name = name.gsub(/\W/, ' ').capitalize
        #   expect(page).to have_unchecked_field('friend[clean_name]')
          # check(@user2.username.gsub(/\W/, ' ').capitalize)

        fill_in 'party[day]', with: '2021-10-10'
        fill_in 'party[start_time]', with: '07:00 PM'

        check('party[Tester1]')
        check('party[Tester2]')
        check('party[Tester3]')
        uncheck('party[Tester3]')

        click_on('Create Party')

        expect(current_path).to eq(dashboard_path)
      end
    end
  end
end
