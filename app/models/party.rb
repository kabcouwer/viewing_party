class Party < ApplicationRecord
  validates :movie_title, presence: true
  validates :duration, presence: true
  validates :day, presence: true
  validates :start_time, presence: true

  has_many :attendees, dependent: :destroy

  def find_host_id
    attendees.where(host_status: 'true').first.user_id
  end
end
