class Attendee < ApplicationRecord
  validates :host_status, inclusion: { in: [true, false] }

  belongs_to :user
  belongs_to :party
end
