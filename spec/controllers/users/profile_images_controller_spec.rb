describe Api::V1::Users::ProfileImagesController do
  let(:user) { create(:user) }
  let(:file) { fixture_file_upload('images/test_image.jpg', 'image/jpeg') }
  let(:params) { { file: file } }

  before { sign_in(user) }

  describe '#create' do
    subject { post :create, params }

    before { allow(ProfileImage::Add).to receive(:for) }

    it 'adds new profile picture for user' do
      expect(ProfileImage::Add).to receive(:for).with(user, file)

      subject
    end
  end

  describe '#update' do
    subject { put :update, params }

    before do
      allow(ProfileImage::Destroy).to receive(:for)
      allow(ProfileImage::Add).to receive(:for)
    end

    it 'replaces user profile picture with new' do
      expect(ProfileImage::Destroy).to receive(:for).with(user)
      expect(ProfileImage::Add).to receive(:for).with(user, file)

      subject
    end
  end
end
