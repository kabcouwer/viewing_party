require 'rails_helper'

RSpec.describe 'User Dashboard Page' do
  before :each do
    # create_factories
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @user4 = create(:user)
    @user5 = create(:user)
    @user6 = create(:user)
    @user7 = create(:user)

    @friendship1 = create(:friendship, user: @user1, friend: @user2)
    @friendship2 = create(:friendship, user: @user1, friend: @user3)
    @friendship3 = create(:friendship, user: @user1, friend: @user4)
    @friendship4 = create(:friendship, user: @user1, friend: @user5)
    @friendship5 = create(:friendship, user: @user2, friend: @user6)

    visit root_path

    fill_in 'email', with: @user1.email
    fill_in 'password', with: @user1.password

    click_on('Log In')
  end

  it 'has a friends section for a logged in user' do
    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content('Friends')
  end
end
