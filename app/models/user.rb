class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  # is validates password behind the scenes magic
  # for password + password confirmation?

  has_many :friendships, dependent: :destroy
  has_many :parties, foreign_key: :party_host_id, dependent: :destroy
  has_many :attendees, dependent: :destroy

  has_secure_password
end
