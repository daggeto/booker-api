describe Event::ValidateReservation do
  let(:start_at) { 30.minutes.since }
  let(:end_at) { start_at + 1.hour }
  let(:status) { Event::Status::FREE }
  let(:event) { create(:event, start_at: start_at, end_at: end_at, status: status) }
  let(:user) { create(:user) }

  subject(:interactor) { described_class.new(event, user) }

  describe '#run' do
    subject { interactor.run }

    it { is_expected.to eq(Event::BookStatus::SUCCESS) }

    context 'when event is not free' do
      let(:status) { Event::Status::PENDING }

      it { is_expected.to eq(Event::BookStatus::CANT_BOOK) }
    end

    context 'when user have booked event' do
      let(:overlapping_event) { create(:event, start_at: start_at - 1.minute, end_at: end_at) }

      let(:user) { create(:user, events: [overlapping_event]) }

      it { is_expected.to eq(Event::BookStatus::USER_EVENTS_OVERLAP) }
    end

    context 'when user have booked his service at same time' do
      let(:overlapping_event) { create(:event, start_at: start_at - 1.minute, end_at: end_at) }
      let(:service) { create(:service, events: [overlapping_event])}
      let(:user) { create(:user, service: service) }

      it { is_expected.to eq(Event::BookStatus::SERVICE_EVENTS_OVERLAP) }
    end
  end
end
