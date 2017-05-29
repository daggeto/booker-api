describe Api::V11::Services::EventsController do
  shared_examples 'events finder' do
    it 'finds events' do
      subject

      expect(json['events'].size).to eq(1)
      expect(json['events'].first['id']).to eq(event.id)
    end
  end

  shared_examples 'includes available days' do
    it 'calls available days interactor' do
      expect(Event::AvailableDays).to receive(:for).with(event.service, available_from)

      subject

      expect(json).to include('available_days')
    end
  end

  describe '#index' do
    let(:user) { create(:user, :with_service) }
    let(:current_user) { user }
    let(:start_at) { Time.zone.now }
    let(:end_at) { start_at + 10.minutes }
    let(:service) { user.service }
    let(:params) { { service_id: service.id, start_at: start_at.beginning_of_day } }

    let!(:future_event) { create(:event, :tomorrow, service: service) }
    let!(:event) do
      create(:event, service: service, start_at: start_at, end_at: end_at)
    end

    before { sign_in(current_user) }

    subject { get :index, params }

    it_behaves_like 'events finder'

    it_behaves_like 'includes available days' do
      let(:available_from) { start_at.beginning_of_week }
    end

    context 'when event start before midnight and ends after' do
      let(:start_at) { Time.zone.now.end_of_day - 10.minutes }
      let(:end_at) { start_at + 20.minutes }

      it_behaves_like 'events finder'
    end

    context 'when current_user is not service owner' do
      let(:current_user) { create(:user) }

      it_behaves_like 'forbidden response'
    end
  end

  describe '#future' do
    let(:current_date) { Time.now }

    let(:event_start_at) { Event::VISIBLE_FROM_TIME.since(current_date) + 1.minute }
    let(:event_end_at) { event_start_at + 10.minutes }
    let(:event) do
      create(:event, :with_service, start_at: event_start_at, end_at: event_end_at)
    end

    let(:request_start_at) { current_date.beginning_of_day }
    let(:params) { { service_id: event.service.id, start_at: request_start_at} }

    let!(:past_event) do
      create(
        :event,
        service: event.service,
        start_at: Event::VISIBLE_FROM_TIME.since - 10.minutes,
        end_at: Event::VISIBLE_FROM_TIME.since + 5.minutes
      )
    end

    before { allow(Time).to receive(:now).and_return(current_date) }

    subject { get :future, params }

    it_behaves_like 'events finder'

    context 'when start_at param is in current week' do
      it_behaves_like 'includes available days' do
        let(:available_from) { Event::VISIBLE_FROM_TIME.since(current_date) }
      end
    end

    context 'when start_at param is in next week' do
      let(:request_start_at) { current_date + 1.week }

      it_behaves_like 'includes available days' do
        let(:available_from) { request_start_at.beginning_of_week }
      end
    end

    context 'when event start before midnight and ends after' do
      let(:event_start_at) { Time.zone.now.end_of_day - 10.minutes }
      let(:event_end_at) { event_start_at + 20.minutes }

      it_behaves_like 'events finder'
    end
  end
end
