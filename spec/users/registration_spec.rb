require 'rails_helper'

RSpec.describe 'Registration Page' do
  before :each do
    visit registration_path
  end

  it 'has form to register new user' do
    username = 'DirtyGertie03'
    email = 'DirtyGertie03@doggo.com'
    password = 'RainbowRoll4lyfe'

    fill_in :username, with: username
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password

    click_on 'Register'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Weclome, #{username}")
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
