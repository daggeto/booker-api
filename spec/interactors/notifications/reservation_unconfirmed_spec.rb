describe Notifications::ReservationUnconfirmed do
  describe '.for' do
    let(:reservation) { create(:full_reservation) }

    subject { described_class.for(reservation) }

    it_behaves_like 'notification sender' do
      let(:receiver) { reservation.user }
      let(:notification_params) do
        hash_including(
          title: match(described_class::TITLE),
          message: match(reservation.event.service.name),
          payload: hash_including(state: AppStates::App::MAIN)
        )
      end
    end
  end
end

