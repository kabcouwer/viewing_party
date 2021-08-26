FactoryBot.define do
  factory :user, aliases: [:friend, :party_host] do
    email { Faker::Internet.email }
    username { Faker::Internet.username }
    password { Faker::Internet.password }
  end

  factory :friendship do
    user
    friend
  end

  factory :party do
    movie_title { Faker::Movie.title }
    duration { Faker::Number.number(digits: 3) }
    day { Faker::Time.forward(23) }
    start_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    party_host
  end

  factory :attendee do
    user
    party
  end
end

# def create_factories
#   # users
#   let!(:user1) { create(:user) }
#   let!(:user2) { create(:user) }
#   let!(:user3) { create(:user) }
#   let!(:user4) { create(:user) }
#   let!(:user5) { create(:user) }
#   let!(:user6) { create(:user) }
#   let!(:user7) { create(:user) }
#   let!(:user8) { create(:user) }
#   let!(:user9) { create(:user) }
#   let!(:user10) { create(:user) }
#
#   # friendships
#   let!(:friendship1) { create(:friendship, user: user1, friend: user2) }
#   let!(:friendship2) { create(:friendship, user: user1, friend: user3) }
#   let!(:friendship3) { create(:friendship, user: user1, friend: user4) }
#   let!(:friendship4) { create(:friendship, user: user1, friend: user5) }
#   let!(:friendship5) { create(:friendship, user: user1, friend: user6) }
#   let!(:friendship6) { create(:friendship, user: user2, friend: user3) }
# end
