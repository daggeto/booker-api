describe Notifications::ReservationCanceledByService do
  describe '.for' do
    let(:reservation) { create(:full_reservation) }

    subject { described_class.for(reservation) }

    it_behaves_like 'notification sender' do
      let(:receiver) { reservation.user }
      let(:notification_params) do
        hash_including(
          title: 'Reservation canceled',
          message: match(reservation.event.service.name).and(match('canceled your registration')),
          payload: hash_including(state: AppStates::App::MAIN)
        )
      end
    end

    context 'when event is past' do
      let(:event) { create(:event, start_at: 1.hour.ago) }
      let(:reservation) { create(:reservation, event: event) }

      it 'does not send notification' do
        expect(Notifications::Send).not_to receive(:for)

        subject
      end
    end
  end
end
