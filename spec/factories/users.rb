FactoryBot.define do
  factory :user do
    name { Faker::StarWars.character }
    messenger_id { nil }
  end
end