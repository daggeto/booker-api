FactoryGirl.define do
  factory :user do
    first_name { Faker::Name::first_name }
    last_name { Faker::Name::last_name }
    email { Faker::Internet.email }
    uid { email }
    password { Faker::Lorem.characters(10) }

    trait :with_service do
      service
    end
  end
end
