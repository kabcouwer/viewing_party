require 'rails_helper'

RSpec.describe 'Registration Page' do
  before :each do
    @username = 'DirtyGertie03'
    @email = 'DirtyGertie03@doggo.com'
    @password = 'RainbowRoll4lyfe'

    visit registration_path
  end

  describe 'happy paths' do
    it 'has form to register new user' do
      fill_in 'user[username]', with: @username
      fill_in 'user[email]', with: @email
      fill_in 'user[password]', with: @password
      fill_in 'user[password_confirmation]', with: @password

      click_on 'Register'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Welcome, #{@username.downcase}")
      expect(page).to have_no_content('Welcome to Viewing Party!')
      expect(page).to have_no_button('Log In')
      expect(page).to have_no_link('New to viewing party? Register here!')
    end
  end

  # Flash messages need to be updated to be more specific
  describe 'sad paths' do
    it 'cannot register a new user with blank fields' do
      fill_in 'user[username]', with: ''
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      fill_in 'user[password_confirmation]', with: ''

      click_on 'Register'

      expect(current_path).to eq(registration_path)
      expect(page).to have_content("Email can't be blank, Username can't be blank, Password can't be blank, and Password is too short (minimum is 6 characters)")
      expect(page).to have_field('user[username]')
      expect(page).to have_field('user[email]')
      expect(page).to have_field('user[password]')
      expect(page).to have_field('user[password_confirmation]')
      expect(page).to have_button('Register')
    end

    it 'cannot register a new user with non-matching passwords' do
      fill_in 'user[username]', with: @username
      fill_in 'user[email]', with: @email
      fill_in 'user[password]', with: 'test'
      fill_in 'user[password_confirmation]', with: 'Test'

      click_on 'Register'

      expect(current_path).to eq(registration_path)
      expect(page).to have_content("Password confirmation doesn't match Password")
      expect(page).to have_field('user[username]')
      expect(page).to have_field('user[email]')
      expect(page).to have_field('user[password]')
      expect(page).to have_field('user[password_confirmation]')
      expect(page).to have_button('Register')
    end

    it 'cannot register a new user with already taken username' do
      taken_user = User.create!(email: @email,
                          username: @username,
                          password: @password,
                          password_confirmation: @password
                        )
      fill_in 'user[username]', with: @username
      fill_in 'user[email]', with: 'random5@dev.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'

      click_on 'Register'

      expect(current_path).to eq(registration_path)
      expect(page).to have_content('Username has already been taken')
      expect(page).to have_field('user[username]')
      expect(page).to have_field('user[email]')
      expect(page).to have_field('user[password]')
      expect(page).to have_field('user[password_confirmation]')
      expect(page).to have_button('Register')
    end

    it 'cannot register a new user with already taken email' do
      taken_user = User.create!(email: @email,
                          username: @username,
                          password: @password,
                          password_confirmation: @password
                        )
      fill_in 'user[username]', with: 'random1234'
      fill_in 'user[email]', with: @email
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'

      click_on 'Register'

      expect(current_path).to eq(registration_path)
      expect(page).to have_content('Email has already been taken')
      expect(page).to have_field('user[username]')
      expect(page).to have_field('user[email]')
      expect(page).to have_field('user[password]')
      expect(page).to have_field('user[password_confirmation]')
      expect(page).to have_button('Register')
    end

    it 'cannot register a new user with already taken email - edgecase' do
      taken_user = User.create!(email: @email,
                          username: @username,
                          password: @password,
                          password_confirmation: @password
                        )
      fill_in 'user[username]', with: 'random1234'
      fill_in 'user[email]', with: 'dirtygertie03@doggo.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'

      click_on 'Register'

      expect(current_path).to eq(registration_path)
      expect(page).to have_content('Email has already been taken')
      expect(page).to have_field('user[username]')
      expect(page).to have_field('user[email]')
      expect(page).to have_field('user[password]')
      expect(page).to have_field('user[password_confirmation]')
      expect(page).to have_button('Register')
    end
  end
end
