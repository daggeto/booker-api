describe Api::V1::ReservationsController do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe '#create' do
    let(:event) { create(:event) }
    let(:params) { { event_id: event.id } }

    subject { post :create, params }

    before { allow(Reservation::Create).to receive(:for) }

    it 'creates reservation' do
      expect(Reservation::Create).to receive(:for).with(event, user)

      subject
    end
  end

  describe '#approve' do
    let(:reservation) { create(:reservation) }

    subject { post :approve, reservation_id: reservation.id }

    before { allow(Reservation::Approve).to receive(:for) }

    it 'approves reservation' do
      expect(Reservation::Approve).to receive(:for).with(reservation)

      subject
    end
  end
end
