FactoryBot.define do
  factory :messenger do
    name { Faker::Pokemon.location }

    factory :messenger_with_users do
      after(:create) do |messenger|
        4.times do
      	  create(:user, messenger: messenger)
        end
      end
    end
  end
end