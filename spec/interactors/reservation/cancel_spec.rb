describe Reservation::Cancel do
  describe '.for' do
    let(:event) { create(:event, :booked) }
    let(:reservation) { create(:reservation, event: event) }

    subject { described_class.for(reservation) }

    before { allow(Notifications::ReservationCanceledByClient).to receive(:for) }

    it_behaves_like 'event status changer' do
      let(:status) { Event::Status::FREE }
    end

    it { has.to change { reservation.canceled_at } }

    it 'sends notification' do
      expect(Notifications::ReservationCanceledByClient).to receive(:for).with(reservation)

      subject
    end
  end
end
