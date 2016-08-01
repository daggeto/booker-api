describe Reservation::Approve do
  describe '.for' do
    let(:reservation) { create(:reservation) }
    let(:event) { reservation.event }

    subject { described_class.for(reservation) }

    before { allow(Notifications::ReservationConfirmed).to receive(:for) }


    it_behaves_like 'event status changer' do
      let(:status) { Event::Status::BOOKED }
    end

    it { has.to change { reservation.approved_at } }

    it 'sends notification' do
      expect(Notifications::ReservationConfirmed).to receive(:for).with(reservation)

      subject
    end
  end
end
