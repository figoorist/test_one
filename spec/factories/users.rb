FactoryBot.define do
  factory :user do
    name { Faker::Pokemon.name }
    messenger_id { nil }
  end
end