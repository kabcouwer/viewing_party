require 'rails_helper'

RSpec.describe 'Welcome Page' do
  before :each do
    visit root_path
  end

  it 'has a welcome message' do
    expect(page).to have_content('Welcome to Viewing Party!')
  end

  it 'has a description of application' do
    description = 'This app allows you to watch movies with your friends.' #expand upon this later if desired
    expect(page).to have_content(description)
  end

  it 'has a link that redirects to new user registration' do
    expect(page).to have_link('New to viewing party? Register here!')

    click_link('New to viewing party? Register here!')

    expect(current_path).to eq(new_user_path)
  end

  it 'has log in button' do
    expect(page).to have_button('Log In')

    click_button('Log In')

    expect(current_path).to eq(root_path)
  end
end

# When a user visits the root path they should be on the welcome page which includes:
#
#  Welcome message
#  Brief description of the application
#  Button to Log in
#  Link to Registration
# Details: Implement basic auth in the application allowing a user to log in with an email and password.
# The password should be stored in the database using bcrypt.
