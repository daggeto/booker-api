FactoryGirl.define do
  factory :service_photo do
    slot 1
    image { File.new('spec/fixtures/images/test_image.jpg') }
  end
end
