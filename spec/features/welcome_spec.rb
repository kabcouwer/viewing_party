require 'rails_helper'

RSpec.describe 'Welcome Page' do
  before :each do
    visit root_path

    @email = 'ex@dev.com'
    @username = 'bill_nye_science_guy'
    @password = 'testing123'

    @user = User.create!(email: @email,
                        username: @username,
                        password: @password,
                        password_confirmation: @password
                      )
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

    expect(current_path).to eq(registration_path)
  end

  it 'has email and password fields and a log in button' do
    expect(page).to have_field('email')
    expect(page).to have_field('password')
    expect(page).to have_button('Log In')
  end

  it 'can login user from welcome page' do
    fill_in 'email', with: @email
    fill_in 'password', with: @password

    click_on('Log In')

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Welcome, #{@user.username}!")
    expect(page).to have_no_content('Welcome to Viewing Party!')
    expect(page).to have_no_button('Log In')
    expect(page).to have_no_link('New to viewing party? Register here!')
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
