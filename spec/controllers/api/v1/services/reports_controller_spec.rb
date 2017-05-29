describe Api::V1::Services::ReportsController do
  describe '#create' do
    let(:service) { create(:service) }
    let(:message) { 'message' }
    let(:params) { { service_id: service.id, message: message } }

    subject { post :create, params }

    before do
      allow(Report::Create).to receive(:for)
    end

    it_behaves_like 'success response'

    it 'creates report' do
      expect(Report::Create).to receive(:for).with(service, has_role?(:guest), message)

      subject
    end

    context 'when user is logged in' do
      let(:user) { create(:user) }

      before { sign_in(user) }

      it 'creates report with user' do
        expect(Report::Create).to receive(:for).with(service, user, message)

        subject
      end
    end
  end
end
