describe Reservation::Remind do
  describe '.for' do
    let(:event) { create(:event) }

    subject { described_class.for(event) }

    before { allow(Notifications::ReservationReminder).to receive(:for) }

    it 'reminds about event' do
      expect(Notifications::ReservationReminder).to receive(:for).with(event)

      subject
    end
  end
end
