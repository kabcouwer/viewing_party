class User < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  has_many :friendships, dependent: :destroy
  has_many :friends, class_name: 'User', through: :friendships, foreign_key: 'friend_id'
  has_many :attendees, dependent: :destroy
  has_many :parties, through: :attendees

  has_secure_password
end
