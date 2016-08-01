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

    subject { post :create, params }

    it_behaves_like 'success response'

    it { has.to change(Event, :count).by(1) }

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

    context 'when current use is not owner of service' do
      let!(:other_user) { create(:user, service: service) }

      it_behaves_like 'forbidden response'
    end
  end

  describe '#cancel' do
    let(:user) { create(:user) }
    let(:event) { create(:event, user: user) }

    subject { post :cancel, event_id: event.id }

    before { allow(Event::Cancel).to receive(:for) }

    it 'cancels event' do
      expect(Event::Cancel).to receive(:for).with(event)

      subject
    end
  end
end