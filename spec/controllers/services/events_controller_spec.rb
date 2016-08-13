describe Api::V1::Services::EventsController do
  before { sign_in(user) }

  shared_examples 'events finder' do
    it 'finds events' do
      subject

      expect(json.size).to eq(1)
      expect(json.first['id']).to eq(event.id)
    end
  end

  describe '#index' do
    let(:user) { create(:user, :with_service) }
    let(:start_at) { Time.zone.now }
    let(:service) { user.service }
    let(:params) { { service_id: service.id, start_at: start_at.beginning_of_day } }
    let!(:future_event) { create(:event, :tomorrow, service: service) }
    let!(:event) do
      create(:event, service: service, start_at: start_at, end_at: start_at + 10.minutes)
    end

    subject { get :index, params }

    it_behaves_like 'events finder'
  end

  describe '#future' do
    let(:user) { create(:user) }
    let(:start_at) { Event::VISIBLE_FROM_TIME.since + 1.minute }
    let(:event) do
      create(:event, :with_service, start_at: start_at, end_at: start_at + 10.minutes)
    end
    let(:params) { { service_id: event.service.id, start_at: start_at.beginning_of_day } }
    let!(:past_event) do
      create(
        :event,
        service: event.service,
        start_at: start_at - 10.minutes,
        end_at: start_at
      )
    end

    subject { get :future, params }

    it_behaves_like 'events finder'
  end
end
