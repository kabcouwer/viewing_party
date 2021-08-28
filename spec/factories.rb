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
