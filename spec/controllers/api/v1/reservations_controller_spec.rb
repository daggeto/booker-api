describe Api::V1::ReservationsController do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe '#create' do
    let(:event) { create(:event, :with_service) }
    let(:params) { { event_id: event.id } }

    subject { post :create, params }

    before do
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
    let(:user) { reservation.event.service.user }
    let(:reservation) { create(:full_reservation) }

    subject { post :approve, reservation_id: reservation.id }

    before { allow(Reservation::Approve).to receive(:for) }

    it 'approves reservation' do
      expect(Reservation::Approve).to receive(:for).with(reservation)

      subject
    end
  end

  describe '#disapprove' do
    let(:user) { reservation.event.service.user }
    let(:reservation) { create(:full_reservation) }

    subject { post :disapprove, reservation_id: reservation.id }

    before { allow(Reservation::Disapprove).to receive(:for) }

    it 'disapproves reservation' do
      expect(Reservation::Disapprove).to receive(:for).with(reservation)

      subject
    end
  end

  describe '#cancel_by_client' do
    let(:user) { reservation.user }
    let(:reservation) { create(:full_reservation) }

    subject { post :cancel_by_client, reservation_id: reservation.id }

    it 'cancel reservation' do
      expect(Reservation::Cancel::ByClient).to receive(:for).with(reservation)

      subject
    end
  end

  describe '#cancel_by_service' do
    let(:user) { reservation.event.service.user }
    let(:reservation) { create(:full_reservation) }

    subject { post :cancel_by_service, reservation_id: reservation.id }

    it 'cancel reservation' do
      expect(Reservation::Cancel::ByService).to receive(:for).with(reservation)

      subject
    end
  end
end
