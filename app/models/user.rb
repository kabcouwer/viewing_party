class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :parties, foreign_key: :party_host_id, dependent: :destroy 
  has_many :attendees, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

  has_secure_password
end
