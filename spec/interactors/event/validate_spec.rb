describe Event::Validate do
  describe '.for' do
    let(:service) { create(:service) }
    let(:user) { create(:user, service: service) }
    let(:start_at) { 30.minutes.since }
    let(:end_at) { start_at + 1.hour }
    let(:params) { { start_at: start_at, end_at: end_at } }

    subject { described_class.for(user, params) }

    it { is_expected.to eq(valid: true, message: Event::Validate::SUCCESS) }

    context 'when event at same time already exists' do
      let!(:event) { create(:event, service: service, start_at: start_at, end_at: end_at) }

      it { is_expected.to eq(valid: false, message: Event::Validate::OVERLAPS_WITH_SERVICE) }
    end

    context 'when user have reservations at this time' do
      let(:event) { create(:event, start_at: start_at, end_at: end_at) }
      let!(:reservation) { create(:reservation, user: user, event: event) }

      it { is_expected.to eq(valid: false, message: Event::Validate::OVERLAPS_WITH_RESERVATION) }
    end
  end
end
