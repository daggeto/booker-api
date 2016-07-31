describe Event::Remind do
  describe '.for' do
    let(:event) { create(:event) }

    subject { described_class.for(event) }

    before { allow(Notifications::EventReminder).to receive(:for) }

    it 'reminds about event' do
      expect(Notifications::EventReminder).to receive(:for).with(event)

      subject
    end
  end
end
