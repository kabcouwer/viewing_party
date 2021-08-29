require 'rails_helper'

RSpec.describe 'User Dashboard Page' do
  before :each do
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @user4 = create(:user)
    @user5 = create(:user)
    @user6 = create(:user)

    @friendship1 = create(:friendship, user: @user1, friend: @user2)
    @friendship2 = create(:friendship, user: @user1, friend: @user3)
    @friendship3 = create(:friendship, user: @user1, friend: @user4)
    @friendship4 = create(:friendship, user: @user2, friend: @user5)
  end

  describe 'happy paths' do
    it 'has no friends message if user has no friends' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user6)

      visit dashboard_path

      expect(page).to have_content('You currently have no friends')
    end

    it 'has a friends list for a logged in user' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      visit dashboard_path

      expect(page).to have_content('Friends')
      expect(page).to have_content(@user2.username)
      expect(page).to have_content(@user3.username)
      expect(page).to have_content(@user4.username)
      expect(page).to have_no_content(@user5.username)
      expect(page).to have_no_content(@user6.username)
    end

    it 'has a friend search where you can add friends' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user6)

      visit dashboard_path

      fill_in 'email', with: @user1.email
      click_button('Add Friend')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content(@user1.username)
    end

    it 'has a friend search where you can add friends - edgcase' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user6)

      visit dashboard_path

      fill_in 'email', with: @user1.email.upcase
      click_button('Add Friend')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content(@user1.username)
    end
  end

  describe 'sad paths' do
    it 'displays error messge if friend cannot be found' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user6)

      visit dashboard_path

      fill_in 'email', with: 'example@dev.com'
      click_button('Add Friend')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Sorry, your friend cannot be found')
    end
  end
end

# As an authenticated user,
# I should see the viewing parties I have been invited to with the following details:
#
# Movie Title, which links to the movie show page
# Date and Time of Event
# who is hosting the event
# list of friends invited, with my name in bold
# I should also see the viewing parties that I have created with the following details:
#
# Movie Title, which links to the movie show page
# Date and Time of Event
# That I am the host of the party
# List of friends invited to the viewing party
