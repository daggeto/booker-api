FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { TEST_PASSWORD }

    trait :with_service do
      after(:create) do |user, _|
        create(:service, user: user)
      end
    end
  end
end
