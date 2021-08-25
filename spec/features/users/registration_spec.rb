require 'rails_helper'

RSpec.describe 'Registration Page' do
  before :each do
    visit registration_path
  end

  it 'has form to register new user' do
    username = 'DirtyGertie03'
    email = 'DirtyGertie03@doggo.com'
    password = 'RainbowRoll4lyfe'

    fill_in 'user[username]', with: username
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on 'Register'

    expect(current_path).to eq(dashboard_path)
    # save_and_open_page
    expect(page).to have_content("Weclome, #{username.downcase}")
  end
end

# When a user visits the '/registration' path they should see a form to register.
# The form should include:
#
#  Email
#  Password
#  Password Confirmation
#  Register Button
# Once the user registers they should be logged in and redirected to the dashboard page
