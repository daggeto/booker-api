FactoryGirl.define do
  factory :report do
    message { Faker::Lorem.sentence(2) }
  end
end
