class User < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_many :friendships, dependent: :destroy
  has_many :friends, class_name: 'User', through: :friendships, foreign_key: 'friend_id'
  has_many :parties, foreign_key: :party_host_id, dependent: :destroy
  has_many :attendees, dependent: :destroy

  has_secure_password
end
