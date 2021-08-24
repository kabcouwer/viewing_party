require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'relationships' do
    it { should belong_to(:party_host) }
    it { should have_many(:attendees) }
  end

  describe 'validations' do
    it { should validate_presence_of(:movie_title) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:day) }
    it { should validate_presence_of(:start_time) }
  end
end
