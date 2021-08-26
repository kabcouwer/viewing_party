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

    expect(current_path).to eq(registration_path)
  end

  it 'has email and password fields and a log in button' do
    expect(page).to have_field('email')
    expect(page).to have_field('password')
    expect(page).to have_button('Log In')
  end
end
