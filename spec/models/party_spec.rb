require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:movie_title) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:day) }
    it { should validate_presence_of(:start_time) }
  end

  describe 'relationships' do
    it { should have_many(:attendees) }
  end

  describe 'instance methods' do
    before :each do
      @user1 = create(:user)
      @user2 = create(:user)
      @user3 = create(:user)
      @user4 = create(:user)
      @user5 = create(:user)

      @friendship1 = create(:friendship, user: @user1, friend: @user2)
      @friendship2 = create(:friendship, user: @user1, friend: @user3)
      @friendship3 = create(:friendship, user: @user1, friend: @user4)
      @friendship4 = create(:friendship, user: @user2, friend: @user5)

      @party1 = create(:party)

      @attendee1 = Attendee.create!(host_status: true, user: @user2, party: @party1)
      @attendee2 = Attendee.create!(user: @user3, party: @party1)
      @attendee3 = Attendee.create!(user: @user4, party: @party1)
    end

    it 'finds party host id' do
      expect(@party1.find_host_id).to eq(@user2.id)
    end
  end
end
