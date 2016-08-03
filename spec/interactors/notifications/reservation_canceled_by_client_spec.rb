describe Notifications::ReservationCanceledByClient do
  describe '.for' do
    let(:reservation) { create(:full_reservation) }

    subject { described_class.for(reservation) }

    it_behaves_like 'notification sender' do
      let(:receiver) { reservation.event.service.user }
      let(:notification_params) do
        hash_including(
          title: 'Event canceled',
          message: match(reservation.user.email).and(match('canceled registration'))
        )
      end
    end
  end
end
