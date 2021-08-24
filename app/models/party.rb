class Party < ApplicationRecord
  belongs_to :party_host, class_name: 'User'
  has_many :attendees, dependent: :destroy

  validates_presence_of :movie_title, :duration, :day, :start_time, require: true
end
