describe Api::V1::Services::ReportsController do
  before { sign_in(user) }

  describe '#create' do
    let(:user) { create(:user) }
    let(:service) { create(:service) }
    let(:message) { 'message' }
    let(:params) { { service_id: service.id, message: message } }

    subject { post :create, params }

    before do
      allow(Report::Create).to receive(:for)
    end

    it_behaves_like 'success response'

    it 'creates report' do
      expect(Report::Create).to receive(:for).with(service, user, message)

      subject
    end
  end
end
