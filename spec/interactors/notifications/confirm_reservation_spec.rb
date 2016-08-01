describe Notifications::ConfirmReservation do
  describe '.for' do
    let(:reservation) { create(:reservation) }
    let(:provider) { reservation.event.service.user }
    let(:client) { reservation.user }

    subject { described_class.for(reservation) }

    it_behaves_like 'notification sender' do
      let(:receiver) { provider }
      let(:notification_params) do
        hash_including(
          title: match('You have booking'),
          message: match(client.email)
        )
      end
    end
  end
end
