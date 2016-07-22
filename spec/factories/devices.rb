FactoryGirl.define do
  factory :device do
    token { Faker::Lorem.characters(10) }
    platform 'ios'
  end
end
