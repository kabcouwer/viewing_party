require 'rails_helper'

RSpec.describe 'Log in Page' do
  before :each do
    visit login_path
  end

  describe 'happy path' do
    it 'can login an already registered user' do
      email = 'ex@dev.com'
      username = 'bill_nye_science_guy'
      password = 'test'

      user = User.create!(email: email,
                          username: username,
                          password: password,
                          password_confirmation: password
                        )

      fill_in 'email', with: email
      fill_in 'password', with: password

      click_on('Log In')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Welcome, #{user.username}!")
      expect(page).to have_no_content('Welcome to Viewing Party!')
      expect(page).to have_no_button('Log In')
      expect(page).to have_no_link('New to viewing party? Register here!')
    end
  end
end
