class Party < ApplicationRecord
  validates :movie_title, presence: true
  validates :duration, presence: true
  validates :day, presence: true
  validates :start_time, presence: true

  belongs_to :party_host, class_name: 'User'
  has_many :attendees, dependent: :destroy
end
