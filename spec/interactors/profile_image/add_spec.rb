describe ProfileImage::Add do
  describe '.for' do
    let(:user) { create(:user) }
    let(:image) do
      Rack::Test::UploadedFile
        .new(
          File.open(File.join(Rails.root, '/spec/fixtures/images/test_image.jpg')),
          'image/jpeg'
        )
    end

    subject { described_class.for(user, image) }

    it { has.to change { user.profile_image } }
  end
end
