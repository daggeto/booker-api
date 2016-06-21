FactoryGirl.define do
  factory :service do
    name { Faker::Lorem.sentence(8) }
    duration { Service::DURATIONS.sample }
    price { [0, Faker::Number.decimal(2)].sample }
    phone { Faker::PhoneNumber.cell_phone }
    address { Faker::Address.street_address }
  end
end