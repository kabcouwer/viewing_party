require 'rails_helper'

RSpec.describe 'Log out funtion' do
  before :each do
    @user = create(:user)
    @welcome_message = 'Welcome to Viewing Party!'
    @description = 'This app allows you to watch movies with your friends.'

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit root_path
  end

  it 'shows the user is logged in' do
    expect(page).to have_content(@welcome_message)
    expect(page).to have_content(@description)
    expect(page).to have_content("Logged in as #{@user.username}")
    expect(page).to have_no_button('Log In')
    expect(page).to have_button('Log Out')
  end

  it 'can logout an already logged in user' do
    click_button('Log Out')

    expect(current_path).to eq(root_path)
    expect(page).to have_no_content('Log Out')
    expect(page).to have_content(@welcome_message)
    expect(page).to have_content(@description)
  end
end
