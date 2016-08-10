describe Reservation::CancelPending do
  describe '.for' do
    let!(:event) { create(:event, :pending, reservation: reservation) }
    let(:reservation) { create(:reservation) }

    subject { described_class.for(reservation) }

    before { allow(Notifications::CanceledWithoutResponse).to receive(:for) }

    it_behaves_like 'event status changer' do
      let(:status) { Event::Status::FREE }
    end

    it { has.to change(Reservation, :count).by(-1) }

    it 'sends notification' do
      expect(Notifications::CanceledWithoutResponse).to receive(:for).with(reservation)

      subject
    end
  end
end
