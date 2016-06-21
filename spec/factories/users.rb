FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(10) }
    provider 0

    trait :with_service do
      provider 1
      service
    end
  end
end