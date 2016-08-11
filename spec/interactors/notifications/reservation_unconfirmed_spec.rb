describe Notifications::ReservationUnconfirmed do
  describe '.for' do
    let(:reservation) { create(:full_reservation) }

    subject { described_class.for(reservation) }

    it_behaves_like 'notification sender' do
      let(:receiver) { reservation.user }
      let(:notification_params) do
        hash_including(
          title: reservation.event.service.name,
          message: match('are not confirmed'),
          payload: hash_including(state: AppStates::App::MAIN)
        )
      end
    end
  end
end

