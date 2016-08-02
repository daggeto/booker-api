describe Notifications::ReservationCanceledByService do
  describe '.for' do
    let(:reservation) { create(:full_reservation) }

    subject { described_class.for(reservation) }

    it_behaves_like 'notification sender' do
      let(:receiver) { reservation.user }
      let(:notification_params) do
        hash_including(
          title: 'Reservation canceled',
          message: match(reservation.event.service.name).and(match('canceled your registration'))
        )
      end
    end
  end
end
