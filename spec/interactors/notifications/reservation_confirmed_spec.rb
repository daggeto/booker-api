describe Notifications::ReservationConfirmed do
  describe '.for' do
    let(:reservation) { create(:full_reservation) }

    subject { described_class.for(reservation) }

    it_behaves_like 'notification sender' do
      let(:receiver) { reservation.user }
      let(:notification_params) do
        hash_including(
          title: match(reservation.event.service.name),
          message: match('Booking confirmed'),
          payload: hash_including(state: AppStates::App::Main::RESERVATIONS)
        )
      end
    end
  end
end
