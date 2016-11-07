FactoryGirl.define do
  factory :service do
    name { Faker::Lorem.sentence(8) }
    duration { Service::DURATIONS.sample }
    price { [0, Faker::Number.decimal(2)].sample }
    phone { Faker::PhoneNumber.cell_phone }
    address { Faker::Address.street_address }

    user

    trait :with_photos do
      after(:create) do |service, _|
        service.service_photos << create(:service_photo)
      end
    end
  end
end
