describe Reservation::Create do
  describe '.for' do
    let(:start_at) { Time.parse('2017-01-01 13:00') }
    let(:start_at_label) { '2017-01-01 13:00' }
    let(:event) { create(:event, :with_service, start_at: start_at) }
    let(:user) { create(:user) }

    before do
      allow(Notifications::ConfirmReservation).to receive(:for)
      allow(GoogleAnalytics::Event::Send).to receive(:for)
    end

    subject { described_class.for(event, user) }

    it 'sends Google Analytics event' do
      expect(GoogleAnalytics::Event::Send)
        .to receive(:for)
        .with(GoogleAnalytics::Events::EVENT_BOOKED.merge(user_id: user.id, label: start_at_label))

      subject
    end

    it_behaves_like 'event status changer' do
      let(:status) { Event::Status::PENDING }
    end

    it { has.to change(Reservation, :count).by(1) }

    it 'sends notification' do
      expect(Notifications::ConfirmReservation).to receive(:for)

      subject
    end
  end
end
