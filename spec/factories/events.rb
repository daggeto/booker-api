FactoryGirl.define do
  factory :event do
    description { Faker::Lorem.sentence(2) }
    status { Event::Status::FREE }
    start_at { Time.now + 1.hour }
    end_at { start_at + 1.hour }

    service

    trait :tomorrow do
      start_at { Time.now + 1.day }
      end_at { start_at + 1.hour }
    end

    trait :free do
      status { Event::Status::FREE }
    end

    trait :booked do
      status { Event::Status::BOOKED }
      reservation
    end

    trait :pending do
      status { Event::Status::PENDING }
      reservation
    end
  end
end
