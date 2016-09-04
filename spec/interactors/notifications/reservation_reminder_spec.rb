describe Notifications::ReservationReminder do
  describe '.for' do
    let(:reservation) { create(:full_reservation) }

    subject { described_class.for(reservation) }

    it_behaves_like 'notification sender' do
      let(:receiver) { reservation.user }
      let(:notification_params) do
        hash_including(
          title: match('Reservation reminder'),
          message: match(reservation.event.service.name),
          payload: hash_including(state: AppStates::App::Main::RESERVATIONS)
        )
      end
    end
  end
end
