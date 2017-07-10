describe Api::V1::Services::ServicePhotosController do
  let(:user) { create(:user) }
  let(:service) { create(:service, user: user) }
  let(:file) { fixture_file_upload('images/test_image.jpg', 'image/jpeg') }
  let(:params) { { service_id: service.id, file: file } }

  before { sign_in(user) }

  describe '#create' do
    let(:profile_image) { create(:profile_image) }

    subject { post :create, params }

    before { allow(ServicePhoto::Add).to receive(:for).and_return(profile_image) }

    it_behaves_like 'success response'

    it 'adds new service photo for user' do
      expect(ServicePhoto::Add).to receive(:for).with(service, file)

      subject
    end
  end
end
