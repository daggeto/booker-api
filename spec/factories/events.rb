FactoryGirl.define do
  factory :event do
    description { Faker::Lorem.sentence(2) }
    status { Event::Status::ALL.sample }
  end
end