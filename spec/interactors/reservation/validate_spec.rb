describe Reservation::Validate do
  describe '.for' do
    let(:user) { create(:user) }
    let(:start_at) { 30.minutes.since }
    let(:end_at) { start_at + 1.hour }
    let(:status) { Event::Status::FREE }
    let(:event) { create(:event, start_at: start_at, end_at: end_at, status: status) }

    subject { described_class.for(event, user) }

    it { is_expected.to eq(valid: true, message: Reservation::Validate::TEST) }

    context 'when event is not free' do
      let(:status) { Event::Status::PENDING }

      it { is_expected.to eq(valid: false, message: Reservation::Validate::CANT_BOOK) }
    end

    context 'when user have reservation' do
      let(:overlapping_event) { create(:event, start_at: start_at - 1.minute, end_at: end_at) }
      let!(:reservation) { create(:reservation, event: overlapping_event, user: user) }

      it { is_expected.to eq(valid: false, message: Reservation::Validate::RESERVED_OVERLAPS) }
    end

    context 'when user have booked his service at same time' do
      let(:overlapping_event) { create(:event, start_at: start_at - 1.minute, end_at: end_at) }
      let(:service) { create(:service, events: [overlapping_event])}
      let(:user) { create(:user, service: service) }

      it { is_expected.to eq(valid: false, message: Reservation::Validate::OWNED_OVERLAPS) }
    end
  end
end
