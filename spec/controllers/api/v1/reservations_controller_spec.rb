describe Api::V1::ReservationsController do
  describe '#create' do
    let(:user) { create(:user) }
    let(:event) { create(:event, :with_service) }
    let(:params) { { event_id: event.id } }

    subject { post :create, params }

    before do
      sign_in(user)

      allow(Reservation::Create).to receive(:for)

      allow(Reservation::Validate).to receive(:for).and_return(valid: true, message: 'OK')
    end

    it_behaves_like 'success response'

    it 'creates reservation' do
      expect(Reservation::Create).to receive(:for).with(event, user)

      subject
    end

    it 'respondes with personalized service' do
      subject

      expect(json['service']).to include('nearest_event')
    end
  end

  describe '#approve' do
    let(:reservation) { create(:full_reservation) }

    subject { post :approve, reservation_id: reservation.id }

    before { sign_in(user) }

    context 'when user is owner of event' do
      let(:user) { reservation.event.service.user }

      before { allow(Reservation::Approve).to receive(:for) }

      it 'approves reservation' do
        expect(Reservation::Approve).to receive(:for).with(reservation)

        subject
      end
    end

    context 'when user does not own event' do
      let(:user) { create(:user) }

      it_behaves_like 'forbidden response'
    end
  end

  describe '#disapprove' do
    let(:reservation) { create(:full_reservation) }

    subject { post :disapprove, reservation_id: reservation.id }

    before { sign_in(user) }

    context 'when user is owner of event' do
      let(:user) { reservation.event.service.user }

      before { allow(Reservation::Disapprove).to receive(:for) }

      it 'disapproves reservation' do
        expect(Reservation::Disapprove).to receive(:for).with(reservation)

        subject
      end
    end

    context 'when user does not own event' do
      let(:user) { create(:user) }

      it_behaves_like 'forbidden response'
    end
  end

  describe '#cancel_by_service' do
    let(:reservation) { create(:full_reservation) }

    subject { post :cancel_by_service, reservation_id: reservation.id }

    before { sign_in(user) }

    context 'when user is owner of event' do
      let(:user) { reservation.event.service.user }

      before { allow(Reservation::Cancel::ByService).to receive(:for) }

      it 'cancel reservation' do
        expect(Reservation::Cancel::ByService).to receive(:for).with(reservation)

        subject
      end
    end

    context 'when user does not own event' do
      let(:user) { create(:user) }

      it_behaves_like 'forbidden response'
    end
  end

  describe '#cancel_by_client' do
    let(:reservation) { create(:full_reservation) }

    subject { post :cancel_by_client, reservation_id: reservation.id }

    before { sign_in(user) }

    context 'when user is booked event' do
      let(:user) { reservation.user }

      it 'cancel reservation' do
        expect(Reservation::Cancel::ByClient).to receive(:for).with(reservation)

        subject
      end
    end

    context 'when user is not booked event' do
      let(:user) { create(:user) }

      it_behaves_like 'forbidden response'
    end
  end
end
