require 'rails_helper'

RSpec.describe 'Log in Page' do
  before :each do
    @email = 'ex@dev.com'
    @username = 'bill_nye_science_guy'
    @password = 'testing123'

    @user = User.create!(email: @email,
                        username: @username,
                        password: @password,
                        password_confirmation: @password
                      )

    visit login_path
  end

  describe 'happy paths' do
    it 'can login an already registered user' do
      fill_in 'email', with: @email
      fill_in 'password', with: @password

      click_on('Log In')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Welcome, #{@user.username}!")
      expect(page).to have_no_content('Welcome to Viewing Party!')
      expect(page).to have_no_button('Log In')
      expect(page).to have_no_link('New to viewing party? Register here!')
    end

    it 'can login an already registered user - edgcase' do
      fill_in 'email', with: 'eX@dEV.cOm'
      fill_in 'password', with: @password

      click_on('Log In')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Welcome, #{@user.username}!")
      expect(page).to have_no_content('Welcome to Viewing Party!')
      expect(page).to have_no_button('Log In')
      expect(page).to have_no_link('New to viewing party? Register here!')
    end
  end

  describe 'sad paths' do
    it 'errors out with unaffiliated email' do
      fill_in 'email', with: 'e@dev.com'
      fill_in 'password', with: @password

      click_on('Log In')

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Sorry, your credentials are invalid. Try Again.')
    end

    it 'errors out with incorrect password' do
      fill_in 'email', with: @email
      fill_in 'password', with: 'incorrectpassword'

      click_on('Log In')

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Sorry, your credentials are invalid. Try Again.')
    end

    it 'errors out with incorrect password -  edgecase' do
      fill_in 'email', with: @email
      fill_in 'password', with: 'teSTINg123'

      click_on('Log In')

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Sorry, your credentials are invalid. Try Again.')
    end

    it 'errors out with blank password' do
      fill_in 'email', with: @email
      fill_in 'password', with: ''

      click_on('Log In')

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Sorry, your credentials are invalid. Try Again.')
    end
  end
end
