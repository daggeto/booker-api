describe Event::Cancel do
  describe '.for' do
    let(:user) { create(:user) }
    let(:event) { create(:event, :booked, user: user) }

    subject { described_class.for(event) }

    before { allow(Notifications::EventCanceledByClient).to receive(:for) }

    it_behaves_like 'event status changer' do
      let(:status) { Event::Status::FREE }
    end

    it { has.to change { event.user }.to(nil) }

    it 'sends notification' do
      expect(Notifications::EventCanceledByClient).to receive(:for).with(user, event)

      subject
    end
  end
end
