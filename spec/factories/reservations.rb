FactoryGirl.define do
  factory :reservation do
    factory :full_reservation do
      event { create(:event, :with_service) }
      user
    end
  end
end
