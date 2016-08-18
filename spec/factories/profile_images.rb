FactoryGirl.define do
  factory :profile_image do
    image { File.new('spec/fixtures/images/test_image.jpg') }
  end
end
