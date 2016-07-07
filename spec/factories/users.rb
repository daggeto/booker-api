FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(10) }

    trait :with_service do
      service
    end
  end
end