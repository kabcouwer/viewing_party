require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:friendships) }
    it { should have_many(:friends).through(:friendships)}
    it { should have_many(:parties) }
    it { should have_many(:attendees) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }

    it { should validate_presence_of(:password) }
  end
end
