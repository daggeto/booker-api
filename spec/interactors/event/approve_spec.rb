describe Event::Approve do
  let(:event) { create(:event) }

  subject(:interactor) { described_class.new(event) }

  before { allow(Notifications::EventBookingConfirmed).to receive(:for) }

  describe '#run' do
    subject { interactor.run }

    it_behaves_like 'status changer' do
      let(:status) { Event::Status::BOOKED }
    end

    it 'sends notification' do
      expect(Notifications::EventBookingConfirmed).to receive(:for).with(event)

      subject
    end
  end
end
