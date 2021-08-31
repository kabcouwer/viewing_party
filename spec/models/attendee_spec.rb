require 'rails_helper'

RSpec.describe Attendee, type: :model do
  describe 'validations' do
    # it { is_expected.to validate_inclusion_of(:host_status).in_array([true, false]) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:party) }
  end
end
