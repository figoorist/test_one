FactoryBot.define do
  factory :messenger do
    name { Faker::Lorem.word }
  end
end