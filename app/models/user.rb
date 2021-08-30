class User < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_many :friendships, dependent: :destroy
  has_many :friends, class_name: 'User', through: :friendships, foreign_key: 'friend_id'
  has_many :parties, foreign_key: :party_host_id, dependent: :destroy
  has_many :attendees, dependent: :destroy

  has_secure_password

  def invites
    Attendee.where(user_id: self.id)
            .map(&:party)
  end
end
# AR docs
# Customer.select(:id).map { |c| c.id }
# # or
# Customer.select(:id).map(&:id)
# # or
# Customer.select(:id, :name).map { |c| [c.id, c.first_name] }
