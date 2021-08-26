require 'rails_helper'

RSpec.describe 'Registration Page' do
  before :each do
    visit registration_path
  end

  describe 'happy path' do
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
      expect(page).to have_content("Welcome, #{username.downcase}")
      expect(page).to have_no_content('Welcome to Viewing Party!')
      expect(page).to have_no_button('Log In')
      expect(page).to have_no_link('New to viewing party? Register here!')
    end
  end
end
