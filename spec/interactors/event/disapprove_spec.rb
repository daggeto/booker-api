describe Event::Disapprove do
  let!(:event) { create(:event, :booked) }

  subject(:interactor) { described_class.new(event) }

  describe '#run' do
    subject { interactor.run }

    before { allow(Notifications::EventBookingUnconfirmed).to receive(:for) }

    it_behaves_like 'status changer' do
      let(:status) { Event::Status::FREE }
    end

    it { has.to change { event.user }.to(nil) }

    it 'sends notification' do
      expect(Notifications::EventBookingUnconfirmed).to receive(:for).with(event)

      subject
    end
  end
end
