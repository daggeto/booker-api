describe Event::Create do
  describe '.for' do
    let(:user) { create(:user) }
    let(:status) { Event::Status::FREE }
    let(:start_at) { '2017-01-01T13:00' }
    let(:start_at_label) { '2017-01-01 13:00' }
    let(:params) { { status: status, start_at: start_at } }

    before { allow(GoogleAnalytics::Event::Send).to receive(:for) }

    subject { described_class.for(user, params) }

    it { has.to change { Event.count }.by(1) }
    it { has.to change { Reservation.count }.by(0) }

    it 'send create event to Google Analytics' do
      expect(GoogleAnalytics::Event::Send)
        .to receive(:for)
        .with(
          GoogleAnalytics::Events::EVENT_CREATED.merge(user_id: user.id, label: start_at_label)
        )

      subject
    end

    context 'when status is not free' do
      let(:status) { Event::Status::PENDING }

      it { has.to change { Reservation.count}.by(1) }
    end
  end
end
