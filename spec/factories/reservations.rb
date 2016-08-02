FactoryGirl.define do
  factory :reservation do
    factory :full_reservation do
      event
      user
    end
  end
end
