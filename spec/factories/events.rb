FactoryGirl.define do
  factory :event do
    description { Faker::Lorem.sentence(2) }
    status { Event::Status::FREE }

    trait :booked do
      user
      status { Event::Status::BOOKED }
    end
  end
end
