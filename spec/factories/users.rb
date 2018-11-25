FactoryBot.define do
  factory :user do
    name { Faker::Pokemon.name }
    messenger_id { nil }
    password { '1111' }
  end
end