describe Notifications::ConfirmReservation do
  describe '.for' do
    let(:reservation) { create(:full_reservation) }
    let(:provider) { reservation.event.service.user }
    let(:client) { reservation.user }

    subject { described_class.for(reservation) }

    it_behaves_like 'notification sender' do
      let(:receiver) { provider }
      let(:notification_params) do
        hash_including(
          title: eq(described_class::TITLE),
          message: match(client.email),
          payload: hash_including(state: AppStates::Service::CALENDAR, stateParams: anything)
        )
      end
    end
  end
end
