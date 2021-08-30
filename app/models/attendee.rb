class Attendee < ApplicationRecord
  validates :host_status, inclusion: { in: [true, false] }
  validates :host_status, acceptance: true

  belongs_to :user
  belongs_to :party
end
