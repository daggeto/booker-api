describe Api::V1::EventsController do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe '#create' do
    let(:service_id) { service.id }
    let(:params) do
      {
        description: 'Description',
        service_id: service_id,
        status: Event::Status::FREE,
        start_at: Time.now,
        end_at: Time.now + 1.hour
      }
    end
    let!(:service) { create(:service, user: user) }
    let(:valid) { true }
    subject { post :create, params }

    before do
      allow(Event::Create).to receive(:for)
      allow(Event::Validate).to receive(:for).and_return(valid: valid)
    end

    it_behaves_like 'success response'

    it 'creates event' do
      expect(Event::Create).to receive(:for)

      subject
    end

    context 'when params is not valid' do
      let(:valid) { false }

      it_behaves_like 'conflict response'
    end

    context 'when current user is not owner of service' do
      let(:other_user) { create(:user, :with_service) }
      let(:service_id) { other_user.service.id }

      it_behaves_like 'forbidden response'
    end
  end

  describe '#update' do
    let(:event) { create(:event) }
    let(:event_id) { event.id }
    let(:params) { { id: event_id, status: Event::Status::PENDING } }
    let!(:service) { create(:service, events: [event], user: user) }

    subject { put :update, params }

    it_behaves_like 'success response'

    it 'creates event' do
      expect(Event::Update).to receive(:for)

      subject
    end

    context 'when current user is not owner of service' do
      let!(:other_user) { create(:user, service: service) }

      it_behaves_like 'forbidden response'
    end
  end
end
